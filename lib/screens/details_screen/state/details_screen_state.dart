import 'dart:io';

import 'package:app/models/note/note.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/item_service.dart';
import 'package:app/service/storage_service.dart';
import 'package:app/service/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class DetailsScreenState {
  final FieldState titleFieldState;
  final FieldState descriptionFieldState;
  final UserState userState;
  final bool isReadOnlyState;
  final bool isPremium;
  final Function() onSaveButtonPressed;
  final Function() onDeleteBtn;
  final Function() switchPremium;
  final Function() switchReadOnly;
  final Function() onPickImagePressed;

  const DetailsScreenState({
    required this.isReadOnlyState,
    required this.isPremium,
    required this.onSaveButtonPressed,
    required this.titleFieldState,
    required this.descriptionFieldState,
    required this.switchPremium,
    required this.switchReadOnly,
    required this.onDeleteBtn,
    required this.userState,
    required this.onPickImagePressed,
  });
}

DetailsScreenState useDetailsScreenState({required Note note}) {
  final itemService = useInjected<ItemService>();
  final userService = useInjected<UserService>();
  final storageService = useInjected<StorageService>();
  final userState = useProvided<UserState>();
  final isPremium = useState<bool>(userState.user!.details.isPremium);
  final isReadOnlyState = useState<bool>(true);
  final titleFieldState = useFieldStateSimple(initialValue: note.details.title);
  final descriptionFieldState = useFieldStateSimple(initialValue: note.details.description);
  final urlFieldState = useFieldStateSimple(initialValue: note.details.url);
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
    }
  }
  final save = useSubmitState(
    submit: (_) async => await itemService.updateItem(
      title: titleFieldState.value,
      description: descriptionFieldState.value,
      id: note.id,
      imageUrl: urlState.value,
      url: urlFieldState.value,
    ),
  );

  final delete = useSubmitState(
    submit: (_) async => await itemService.deleteItem(id: note.id),
  );

  final switchPremium = useSubmitState(submit: (_) async {
    isPremium.value = !isPremium.value;
    await userService.switchPremium(email: userState.user!.details.email, id: userState.user!.id, isPremium: isPremium.value);
  });

  final switchReadOnly = useSubmitState(submit: (_) async => isReadOnlyState.value = !isReadOnlyState.value);

  return DetailsScreenState(
    onSaveButtonPressed: () {
      if (titleFieldState.value != '') {
        save.submitWithInput(null);
      }
    },
    onDeleteBtn: () {
      delete.submitWithInput(null);
    },
    switchReadOnly: () {
      switchReadOnly.submitWithInput(null);
    },
    isReadOnlyState: isReadOnlyState.value,
    descriptionFieldState: descriptionFieldState,
    titleFieldState: titleFieldState,
    switchPremium: () {
      switchPremium.submitWithInput(null);
    },
    onPickImagePressed: () => openGallery(),
    userState: userState,
    isPremium: isPremium.value,
  );
}
