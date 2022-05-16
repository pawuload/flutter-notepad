import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:app/screens/details/details_screen_args.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/view/details_screen_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_utils/utopia_utils.dart';

class DetailsScreen extends HookWidget {
  static const route = '/details';
  static final routeConfig = RouteConfig.material(() => const DetailsScreen());

  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final args = context.routeArgs<DetailsScreenArgs>();
    final state = useDetailsScreenState(
      note: args!.note,
      navigateBack: (value) => navigator.pop(value),
      showPremiumDialog: (item) async => await AppAlertDialog.showPremium(context, item: item),
      showDeleteDialog: () async => await AppAlertDialog.showDelete(context),
      showExitDialog: () async => await AppAlertDialog.showExit(context),
    );

    return DetailsScreenView(state: state);
  }
}
