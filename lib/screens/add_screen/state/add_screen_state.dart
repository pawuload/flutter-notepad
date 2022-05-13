import 'dart:async';
import 'dart:io';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/item_service.dart';
import 'package:app/service/storage_service.dart';
import 'package:app/service/user_service.dart';
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
  final Function() switchReadOnly;
  final bool isReadOnlyState;
  final UserState userState;
  final int timeLeft;
  final bool isPremium;

  const AddScreenState({
    required this.titleState,
    required this.urlState,
    required this.isPremium,
    required this.descriptionState,
    required this.onSaveButtonPressed,
    required this.isReadOnlyState,
    required this.userState,
    required this.timeLeft,
    required this.switchReadOnly,
    required this.onPickImagePressed,
  });
}

AddScreenState useAddScreenState({required Future<bool?> Function() showPremiumDialog}) {
  final itemService = useInjected<ItemService>();
  final userService = useInjected<UserService>();
  final storageService = useInjected<StorageService>();
  final titleState = useFieldStateSimple();
  final descriptionState = useFieldStateSimple();
  final urlFieldState = useFieldStateSimple();
  final userState = useProvided<UserState>();
  final isPremium = useState<bool>(userState.user!.details.isPremium);
  final isReadOnlyState = useState<bool>(false);
  final timeLeft = useState<int>(30);
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
    }
  }

  Future<void> save() async {
    await itemService.saveItem(
      title: titleState.value,
      description: descriptionState.value,
      imageUrl: urlState.value,
      url: urlFieldState.value,
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
    onSaveButtonPressed: () {
      if (titleState.value != '') {
        save();
      }
    },
    switchReadOnly: () => isReadOnlyState.value = !isReadOnlyState.value,
    titleState: titleState,
    descriptionState: descriptionState,
    urlState: urlFieldState,
    userState: userState,
    timeLeft: timeLeft.value,
    isReadOnlyState: isReadOnlyState.value,
    onPickImagePressed: () => openGallery(),
    isPremium: isPremium.value,
  );
}
