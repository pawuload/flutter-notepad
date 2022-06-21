import 'dart:async';
import 'dart:io';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/item_service.dart';
import 'package:app/service/storage_service.dart';
import 'package:app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AddScreenState {
  final FieldState titleState;
  final FieldState descriptionState;
  final FieldState urlState;
  final Function() onSaveButtonPressed;
  final Function() onPickImagePressed;
  final Function() onLinkPressed;
  final Function() onVideoPressed;
  final Function() switchReadOnly;
  final Function() onWillPop;
  final bool isReadOnly;
  final bool isLoading;
  final bool isLinkTabOpen;
  final bool isPremium;
  final int timeLeft;

  const AddScreenState({
    required this.titleState,
    required this.urlState,
    required this.isPremium,
    required this.descriptionState,
    required this.onSaveButtonPressed,
    required this.onLinkPressed,
    required this.onVideoPressed,
    required this.isReadOnly,
    required this.isLoading,
    required this.isLinkTabOpen,
    required this.timeLeft,
    required this.switchReadOnly,
    required this.onPickImagePressed,
    required this.onWillPop,
  });
}

AddScreenState useAddScreenState({
  required Future<bool?> Function() showPremiumDialog,
  required Future<bool?> Function() showExitDialog,
  required Future<bool?> Function() showSaveDialog,
  required Function(bool?) navigateBack,
}) {
  final itemService = useInjected<ItemService>();
  final userService = useInjected<UserService>();
  final storageService = useInjected<StorageService>();
  final titleState = useFieldStateSimple();
  final descriptionState = useFieldStateSimple();
  final urlFieldState = useFieldStateSimple();
  final userState = useProvided<UserState>();
  final isPremium = useState<bool>(userState.user!.details.isPremium);
  final isReadOnlyState = useState<bool>(false);
  final isLinkTabOpen = useState<bool>(false);
  final isLoading = useState<bool>(false);
  final timeLeft = useState<int>(30);
  final context = useContext();
  final stopwatch = useMemoized(
    () => StopWatchTimer(
      onChangeRawSecond: (value) => timeLeft.value = 30 - value,
    ),
  );
  final fileState = useState<File?>(null);
  final imageUrlState = useState<List<String>?>([]);
  final videoUrlState = useState<String?>(null);
  final ImagePicker imagePicker = ImagePicker();

  Future<void> showSnackBar({required String text, required Color color}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> switchPremium() async {
    isPremium.value = !isPremium.value;
    await userService.switchPremium(
      email: userState.user!.details.email,
      id: userState.user!.id,
      isPremium: isPremium.value,
    );
  }

  Future<void> switchLoading() async => isLoading.value = !isLoading.value;

  Future openGallery() async {
    if (isLoading.value == true) {
      showSnackBar(
        text: 'Wait until uploading is finished',
        color: Colors.red.withOpacity(0.5),
      );
    } else if (imageUrlState.value!.length >= 9) {
      showSnackBar(
        text: 'You can upload up to 9 images only',
        color: Colors.red.withOpacity(0.5),
      );
    } else {
      if (isPremium.value == false) {
        stopwatch.onExecute.add(StopWatchExecute.stop);
      }
      final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery,
      );
      switchLoading();
      if (pickedFile != null) {
        fileState.value = File(pickedFile.path);
        if (fileState.value!.lengthSync() > 30000000) {
          stopwatch.onExecute.add(StopWatchExecute.start);
          showSnackBar(
            text: 'File is too big',
            color: Colors.red.withOpacity(0.5),
          );
          switchLoading();
          return;
        }
        final String? img = await storageService.uploadFile(fileState.value!, name: '/notes');
        imageUrlState.value!.add(img!);
        switchLoading();
        if (isPremium.value == false) {
          stopwatch.onExecute.add(StopWatchExecute.start);
        }
        showSnackBar(
          text: 'Image has been added',
          color: Colors.green.withOpacity(0.5),
        );
      } else {
        switchLoading();
        if (isPremium.value == false) {
          stopwatch.onExecute.add(StopWatchExecute.start);
        }
        showSnackBar(
          text: 'Problem with sending image. Try again',
          color: Colors.red.withOpacity(0.5),
        );
      }
    }
  }

  Future openVideoGallery() async {
    if (isLoading.value == true) {
      showSnackBar(
        text: 'Wait until uploading is finished',
        color: Colors.red.withOpacity(0.5),
      );
    } else {
      if (isPremium.value == false) {
        stopwatch.onExecute.add(StopWatchExecute.stop);
      }
      final pickedFile = await imagePicker.getVideo(
        source: ImageSource.gallery,
      );
      switchLoading();
      if (pickedFile != null) {
        fileState.value = File(pickedFile.path);
        if (fileState.value!.lengthSync() > 40000000) {
          if (isPremium.value == false) {
            stopwatch.onExecute.add(StopWatchExecute.start);
          }
          showSnackBar(
            text: 'File is too big',
            color: Colors.red.withOpacity(0.5),
          );
          switchLoading();
          return;
        }
        videoUrlState.value = await storageService.uploadFile(fileState.value!, name: '/notes');
        switchLoading();
        if (isPremium.value == false) {
          stopwatch.onExecute.add(StopWatchExecute.start);
        }
        showSnackBar(
          text: 'Video has been added',
          color: Colors.green.withOpacity(0.5),
        );
      } else {
        switchLoading();
        if (isPremium.value == false) {
          stopwatch.onExecute.add(StopWatchExecute.start);
        }
        showSnackBar(
          text: 'Problem with sending video. Try again',
          color: Colors.red.withOpacity(0.5),
        );
      }
    }
  }

  Future<void> onSavePressed() async {
    if (titleState.value != '') {
      await itemService.saveItem(
        title: titleState.value,
        description: descriptionState.value,
        imageUrl: imageUrlState.value,
        videoUrl: videoUrlState.value,
        url: urlFieldState.value,
      );
      navigateBack(true);
    } else {
      showSnackBar(
        text: 'To save a note you must put a title',
        color: Colors.red.withOpacity(0.5),
      );
    }
  }

  Future<void> onLinkPressed() async {
    isLinkTabOpen.value = !isLinkTabOpen.value;
  }

  useMemoized(
    () async {
      if (isPremium.value == false) {
        stopwatch.onExecute.add(StopWatchExecute.start);
      }
    },
  );

  useSimpleEffect(() async {
    if (timeLeft.value == 0) {
      stopwatch.onExecute.add(StopWatchExecute.stop);
      isReadOnlyState.value = !isReadOnlyState.value;
      final result = await showPremiumDialog();
      if (result == true) {
        isReadOnlyState.value = !isReadOnlyState.value;
        await switchPremium();
        userState.refresh();
      }
    }
  }, [timeLeft.value]);

  Future<bool> onWillPop() async {
    final result = await showExitDialog();
    if (result == true) {
      stopwatch.onExecute.add(StopWatchExecute.stop);
      return true;
    } else {
      return false;
    }
  }

  return AddScreenState(
    onVideoPressed: () => openVideoGallery(),
    onSaveButtonPressed: () async {
      if (isLoading.value == false) {
        onSavePressed();
      } else {
        final result = await showSaveDialog();
        if (result == true) {
          if (titleState.value != '') {
            isLoading.value ? switchLoading() : null;
            isPremium.value ? stopwatch.onExecute.add(StopWatchExecute.stop) : null;
            onSavePressed();
          }
        } else {
          return false;
        }
      }
    },
    onLinkPressed: () => onLinkPressed(),
    switchReadOnly: () => isReadOnlyState.value = !isReadOnlyState.value,
    onWillPop: () => onWillPop(),
    titleState: titleState,
    descriptionState: descriptionState,
    urlState: urlFieldState,
    timeLeft: timeLeft.value,
    isReadOnly: isReadOnlyState.value,
    onPickImagePressed: () => openGallery(),
    isPremium: isPremium.value,
    isLoading: isLoading.value,
    isLinkTabOpen: isLinkTabOpen.value,
  );
}
