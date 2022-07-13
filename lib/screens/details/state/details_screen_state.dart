import 'dart:io';
import 'package:app/models/note/note.dart';
import 'package:app/models/premium_dialog/premium_dialog_item.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/item_service.dart';
import 'package:app/service/storage_service.dart';
import 'package:app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class DetailsScreenState {
  final Note note;
  final FieldState titleFieldState;
  final FieldState descriptionFieldState;
  final FieldState urlFieldState;
  final Function() onSaveButtonPressed;
  final Function() onDeletePressed;
  final Function() onLinkPressed;
  final Function() switchReadOnly;
  final Function() onPickImagePressed;
  final Function() onTabOpenPressed;
  final Function() onEditPressed;
  final Function() onExitPressed;
  final Function() onVideoPressed;
  final Function() onWillPop;
  final Function(String) navigateToFullScreen;
  final bool isReadOnly;
  final bool isLinkTabOpen;
  final bool isPremium;
  final bool isTabOpen;
  final bool isLoading;

  const DetailsScreenState({
    required this.note,
    required this.isReadOnly,
    required this.isLinkTabOpen,
    required this.isPremium,
    required this.isTabOpen,
    required this.isLoading,
    required this.onSaveButtonPressed,
    required this.onLinkPressed,
    required this.titleFieldState,
    required this.descriptionFieldState,
    required this.urlFieldState,
    required this.switchReadOnly,
    required this.onDeletePressed,
    required this.onPickImagePressed,
    required this.navigateToFullScreen,
    required this.onTabOpenPressed,
    required this.onEditPressed,
    required this.onExitPressed,
    required this.onVideoPressed,
    required this.onWillPop,
  });
}

DetailsScreenState useDetailsScreenState({
  required Note note,
  required Future<bool?> Function(PremiumDialogItem) showPremiumDialog,
  required Future<bool?> Function() showDeleteDialog,
  required Future<bool?> Function() showExitDialog,
  required Future<bool?> Function() showSaveDialog,
  required Function(bool) navigateBack,
  required Function(String) navigateToVideo,
}) {
  final itemService = useInjected<ItemService>();
  final userService = useInjected<UserService>();
  final storageService = useInjected<StorageService>();
  final userState = useProvided<UserState>();
  final isPremium = useState<bool>(userState.user!.details.isPremium);
  final isReadOnlyState = useState<bool>(true);
  final isTabOpen = useState<bool>(false);
  final titleFieldState = useFieldStateSimple(initialValue: note.details.title);
  final descriptionFieldState = useFieldStateSimple(initialValue: note.details.description);
  final urlFieldState = useFieldStateSimple(initialValue: note.details.url);
  final fileState = useState<File?>(null);
  final isLinkTabOpen = useState<bool>(false);
  final isLoading = useState<bool>(false);
  final context = useContext();
  final imageUrlState = useState<List<String>?>(note.details.imageUrl);
  final videoUrlState = useState<String?>(note.details.videoUrl);
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

  Future<void> showWarningSnackBar() async {
    showSnackBar(
      text: 'You can upload up to 12 images only',
      color: Colors.red.withOpacity(0.5),
    );
  }

  Future<void> switchPremium() async {
    isPremium.value = !isPremium.value;
    await userService.switchPremium(
      email: userState.user!.details.email,
      id: userState.user!.id,
      isPremium: isPremium.value,
    );
    userState.refresh();
  }

  Future<void> switchReadOnly() async {
    isLoading.value = false;
    isReadOnlyState.value = !isReadOnlyState.value;
  }

  Future<void> switchLoading() async => isLoading.value = !isLoading.value;

  Future openGallery() async {
    if (isLoading.value == true) {
      showSnackBar(
        text: 'Wait until uploading is finished',
        color: Colors.red.withOpacity(0.5),
      );
    } else if (imageUrlState.value!.length >= 12) {
      showWarningSnackBar();
    } else {
      final List<PickedFile?> list = [];
      final pickedFile = await imagePicker.getMultiImage();
      if (pickedFile != null) {
        if (pickedFile.length > (12 - imageUrlState.value!.length)) {
          showWarningSnackBar();
          return;
        }
        switchLoading();
        list.addAll(pickedFile);

        for (int i = 0; i < list.length; i++) {
          if (imageUrlState.value!.length < 12) {
            fileState.value = File(list[i]!.path);
            if (fileState.value!.lengthSync() > 10000000) {
              if (pickedFile.length == 1) {
                showSnackBar(
                  text: 'File is too big to upload',
                  color: Colors.red.withOpacity(0.5),
                );
              } else {
                showSnackBar(
                  text: 'Some files are too big to upload',
                  color: Colors.red.withOpacity(0.5),
                );
              }
              switchLoading();
              return;
            }
            final String? img = await storageService.uploadFile(fileState.value!, name: '/notes');
            imageUrlState.value!.add(img!);
          }
        }

        switchLoading();
        showSnackBar(
          text: 'Images have been added',
          color: Colors.green.withOpacity(0.5),
        );
      } else {
        switchLoading();
        showSnackBar(
          text: 'Problem with sending image. Try again',
          color: Colors.red.withOpacity(0.5),
        );
        if (isLoading.value == true) switchLoading();
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
      final pickedFile = await imagePicker.getVideo(
        source: ImageSource.gallery,
      );
      switchLoading();
      if (pickedFile != null) {
        fileState.value = File(pickedFile.path);
        if (fileState.value!.lengthSync() > 40000000) {
          showSnackBar(
            text: 'File is too big to upload',
            color: Colors.red.withOpacity(0.5),
          );
          switchLoading();
          return;
        }
        videoUrlState.value = await storageService.uploadFile(fileState.value!, name: '/notes');

        switchLoading();
        showSnackBar(
          text: 'Video has been added',
          color: Colors.green.withOpacity(0.5),
        );
      } else {
        switchLoading();
        showSnackBar(
          text: 'Problem with sending video. Try again',
          color: Colors.red.withOpacity(0.5),
        );
      }
    }
  }

  Future<void> onLinkPressed() async => isLinkTabOpen.value = !isLinkTabOpen.value;

  Future<void> onTabOpenPressed() async => isTabOpen.value = !isTabOpen.value;

  Future<void> onSavePressed() async {
    if (titleFieldState.value != '') {
      await itemService.updateItem(
        title: titleFieldState.value,
        description: descriptionFieldState.value,
        id: note.id,
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

  Future<void> edit() async {
    if (isPremium.value == false) {
      final result = await showPremiumDialog(PremiumDialogItem.details);
      if (result == true) {
        switchPremium();
        switchReadOnly();
      }
    } else {
      switchReadOnly();
    }
  }

  Future<void> delete() async {
    final result = await showDeleteDialog();
    if (result == true) {
      await itemService.deleteItem(id: note.id);
      navigateBack(true);
    }
  }

  Future<bool> onWillPop() async {
    if (isReadOnlyState.value == false) {
      final result = await showExitDialog();
      if (result == true) {
        switchReadOnly();
        return false;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  return DetailsScreenState(
    onSaveButtonPressed: () async {
      if (isLoading.value == false) {
        onSavePressed();
      } else {
        final result = await showSaveDialog();
        if (result == true) {
          if (titleFieldState.value != '') {
            isLoading.value ? switchLoading() : null;
            onSavePressed();
          }
        } else {
          return false;
        }
      }
    },
    onTabOpenPressed: () => onTabOpenPressed(),
    onLinkPressed: () => onLinkPressed(),
    onDeletePressed: () => delete(),
    switchReadOnly: () => switchReadOnly(),
    isReadOnly: isReadOnlyState.value,
    descriptionFieldState: descriptionFieldState,
    titleFieldState: titleFieldState,
    onPickImagePressed: () => openGallery(),
    isPremium: isPremium.value,
    isTabOpen: isTabOpen.value,
    isLoading: isLoading.value,
    isLinkTabOpen: isLinkTabOpen.value,
    urlFieldState: urlFieldState,
    note: note,
    onEditPressed: () => edit(),
    onExitPressed: () => navigateBack(false),
    onVideoPressed: () => openVideoGallery(),
    onWillPop: () => onWillPop(),
    navigateToFullScreen: (path) => navigateToVideo(path),
  );
}
