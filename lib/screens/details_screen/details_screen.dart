import 'package:app/screens/details_screen/details_screen_args.dart';
import 'package:app/screens/details_screen/state/details_screen_state.dart';
import 'package:app/screens/details_screen/view/details_screen_view.dart';
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
    );

    return DetailsScreenView(state: state);
  }
}
