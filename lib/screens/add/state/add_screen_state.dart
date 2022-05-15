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
  final Function() onExitPressed;
  final Function() switchReadOnly;
  final bool isReadOnly;
  final bool isLinkTabOpen;
  final int timeLeft;
  final bool isPremium;

  const AddScreenState({
    required this.titleState,
    required this.urlState,
    required this.isPremium,
    required this.descriptionState,
    required this.onSaveButtonPressed,
    required this.onLinkPressed,
    required this.onExitPressed,
    required this.isReadOnly,
    required this.isLinkTabOpen,
    required this.timeLeft,
    required this.switchReadOnly,
    required this.onPickImagePressed,
  });
}

AddScreenState useAddScreenState({
  required Future<bool?> Function() showPremiumDialog,
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
  final timeLeft = useState<int>(30);
  final context = useContext();
  final stopwatch = useMemoized(
    () => StopWatchTimer(
      onChangeRawSecond: (value) => timeLeft.value = 30 - value,
    ),
  );
  final fileState = useState<File?>(null);
  final urlState = useState<String?>(null);
  final ImagePicker imagePicker = ImagePicker();

  Future openGallery() async {
    final pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      fileState.value = File(pickedFile.path);
      urlState.value = await storageService.uploadFile(fileState.value!, name: '/notes');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Image has been added',
          ),
          backgroundColor: Colors.green.withOpacity(0.5),
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Problem with sending image. Try again',
          ),
          backgroundColor: Colors.red.withOpacity(0.5),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> onSavePressed() async {
    if (titleState.value != '') {
      await itemService.saveItem(
        title: titleState.value,
        description: descriptionState.value,
        imageUrl: urlState.value,
        url: urlFieldState.value,
      );
      navigateBack(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'To save a note you must put a title',
          ),
          backgroundColor: Colors.red.withOpacity(0.5),
          duration: const Duration(milliseconds: 1700),
        ),
      );
    }
  }

  Future<void> switchPremium() async {
    isPremium.value = !isPremium.value;
    await userService.switchPremium(
      email: userState.user!.details.email,
      id: userState.user!.id,
      isPremium: isPremium.value,
    );
  }

  Future<void> onLinkPressed() async {
    isLinkTabOpen.value = !isLinkTabOpen.value;
  }

  useMemoized(() async {
    if (isPremium.value == false) {
      stopwatch.onExecute.add(StopWatchExecute.start);
    }
  });

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

  return AddScreenState(
    onExitPressed: () => navigateBack(false),
    onSaveButtonPressed: () => onSavePressed(),
    onLinkPressed: () => onLinkPressed(),
    switchReadOnly: () => isReadOnlyState.value = !isReadOnlyState.value,
    titleState: titleState,
    descriptionState: descriptionState,
    urlState: urlFieldState,
    timeLeft: timeLeft.value,
    isReadOnly: isReadOnlyState.value,
    onPickImagePressed: () => openGallery(),
    isPremium: isPremium.value,
    isLinkTabOpen: isLinkTabOpen.value,
  );
}
