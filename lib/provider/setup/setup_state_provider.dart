import 'package:flutter/cupertino.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SetupState {
  final bool isInitialized;

  const SetupState({required this.isInitialized});
}

class SetupStateProvider extends HookStateProviderWidget<SetupState> {
  const SetupStateProvider({Key? key}) : super(key: key);

  @override
  SetupState use() {
    final isInitializedValue = useState<bool>(false);

    useSimpleEffect(() async {
      await Future.wait([
        Future.delayed(const Duration(seconds: 1)),
      ]);
      isInitializedValue.value = true;
    }, []);

    return SetupState(isInitialized: isInitializedValue.value);
  }
}
