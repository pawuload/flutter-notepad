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
  final bool isReadOnly;
  final bool isLinkTabOpen;
  final bool isPremium;
  final bool isTabOpen;
  final bool isLoading;
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
    required this.onTabOpenPressed,
    required this.onEditPressed,
    required this.onExitPressed,
    required this.onVideoPressed,
    required this.onWillPop,
  });
}

DetailsScreenState useDetailsScreenState({
  required Note note,
  required Function(bool) navigateBack,
  required Future<bool?> Function(PremiumDialogItem) showPremiumDialog,
  required Future<bool?> Function() showDeleteDialog,
  required Future<bool?> Function() showExitDialog,
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
  final imageUrlState = useState<String?>(note.details.imageUrl);
  final videoUrlState = useState<String?>(note.details.videoUrl);
  final ImagePicker imagePicker = ImagePicker();

  Future openGallery() async {
    final pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    isLoading.value = !isLoading.value;

    if (pickedFile != null) {
      fileState.value = File(pickedFile.path);
      imageUrlState.value = await storageService.uploadFile(fileState.value!, name: '/notes');

      isLoading.value = !isLoading.value;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Image has been added',
          ),
          backgroundColor: Colors.green.withOpacity(0.5),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      isLoading.value = !isLoading.value;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Problem with sending image. Try again',
          ),
          backgroundColor: Colors.red.withOpacity(0.5),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future openVideoGallery() async {
    final pickedFile = await imagePicker.getVideo(
      source: ImageSource.gallery,
    );

    isLoading.value = !isLoading.value;

    if (pickedFile != null) {
      fileState.value = File(pickedFile.path);
      videoUrlState.value = await storageService.uploadFile(fileState.value!, name: '/notes');

      isLoading.value = !isLoading.value;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Video has been added',
          ),
          backgroundColor: Colors.green.withOpacity(0.5),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      isLoading.value = !isLoading.value;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Problem with sending video. Try again',
          ),
          backgroundColor: Colors.red.withOpacity(0.5),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> onLinkPressed() async {
    isLinkTabOpen.value = !isLinkTabOpen.value;
  }

  Future<void> onTabOpenPressed() async {
    isTabOpen.value = !isTabOpen.value;
  }

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'To save a note you must put a title',
          ),
          backgroundColor: Colors.red.withOpacity(0.5),
          duration: const Duration(milliseconds: 1500),
        ),
      );
    }
  }

  Future<void> delete() async {
    final result = await showDeleteDialog();
    if (result == true) {
      await itemService.deleteItem(id: note.id);
      navigateBack(true);
    }
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

  Future<void> switchReadOnly() async => isReadOnlyState.value = !isReadOnlyState.value;

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
    onSaveButtonPressed: () => onSavePressed(),
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
  );
}
