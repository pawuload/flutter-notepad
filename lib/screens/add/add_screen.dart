import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:app/models/premium_dialog/premium_dialog_item.dart';
import 'package:app/screens/add/state/add_screen_state.dart';
import 'package:app/screens/add/view/add_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_arch/utopia_arch.dart';

class AddScreen extends HookWidget {
  static const route = '/add';
  static final routeConfig = RouteConfig.material(() => const AddScreen());

  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useAddScreenState(
      showPremiumDialog: () async {
        return await AppAlertDialog.showPremium(
          context,
          item: PremiumDialogItem.time,
        );
      },
      showExitDialog: () async => await AppAlertDialog.showExit(context),
      showSaveDialog: () async => await AppAlertDialog.showSave(context),
      navigateBack: (value) => navigator.pop(value),
    );

    return AddScreenView(state: state);
  }
}
