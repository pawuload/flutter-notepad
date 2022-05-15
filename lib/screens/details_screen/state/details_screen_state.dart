import 'dart:io';

import 'package:app/models/note/note.dart';
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
  final UserState userState;
  final bool isReadOnlyState;
  final bool isLinkTabOpen;
  final bool isPremium;
  final bool isTabOpen;
  final Function() onSaveButtonPressed;
  final Function() onDeletePressed;
  final Function() onLinkPressed;
  final Function() switchPremium;
  final Function() switchReadOnly;
  final Function() onPickImagePressed;
  final Function() onTabOpenPressed;

  const DetailsScreenState({
    required this.note,
    required this.isReadOnlyState,
    required this.isLinkTabOpen,
    required this.isPremium,
    required this.isTabOpen,
    required this.onSaveButtonPressed,
    required this.onLinkPressed,
    required this.titleFieldState,
    required this.descriptionFieldState,
    required this.urlFieldState,
    required this.switchPremium,
    required this.switchReadOnly,
    required this.onDeletePressed,
    required this.userState,
    required this.onPickImagePressed,
    required this.onTabOpenPressed,
  });
}

DetailsScreenState useDetailsScreenState({
  required Note note,
  required Function(bool) navigateBack,
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
  final context = useContext();
  final urlState = useState<String?>(note.details.imageUrl);
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

  Future<void> onLinkPressed() async {
    isLinkTabOpen.value = !isLinkTabOpen.value;
  }

  Future<void> onTabOpenPressed() async => isTabOpen.value = !isTabOpen.value;

  Future<void> onSavePressed() async {
    if (titleFieldState.value != '') {
      await itemService.updateItem(
        title: titleFieldState.value,
        description: descriptionFieldState.value,
        id: note.id,
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
          duration: const Duration(milliseconds: 1500),
        ),
      );
    }
  }

  Future<void> delete() async => await itemService.deleteItem(id: note.id);

  Future<void> switchPremium() async {
    isPremium.value = !isPremium.value;
    await userService.switchPremium(
      email: userState.user!.details.email,
      id: userState.user!.id,
      isPremium: isPremium.value,
    );
  }

  Future<void> switchReadOnly() async => isReadOnlyState.value = !isReadOnlyState.value;

  return DetailsScreenState(
    onSaveButtonPressed: () => onSavePressed(),
    onTabOpenPressed: () => onTabOpenPressed(),
    onLinkPressed: () => onLinkPressed(),
    onDeletePressed: () => delete(),
    switchReadOnly: () => switchReadOnly(),
    isReadOnlyState: isReadOnlyState.value,
    descriptionFieldState: descriptionFieldState,
    titleFieldState: titleFieldState,
    switchPremium: () => switchPremium(),
    onPickImagePressed: () => openGallery(),
    userState: userState,
    isPremium: isPremium.value,
    isTabOpen: isTabOpen.value,
    isLinkTabOpen: isLinkTabOpen.value,
    urlFieldState: urlFieldState,
    note: note,
  );
}
