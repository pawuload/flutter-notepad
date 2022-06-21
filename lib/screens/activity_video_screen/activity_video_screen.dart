import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_utils/utopia_utils.dart';

import 'activity_video_screen_args.dart';
import 'state/use_activity_video_screen_state.dart';
import 'view/actiivity_video_screen_view.dart';

class ActivityVideoScreen extends HookWidget {
  static final route = '/video';
  static final routeConfig = RouteConfig.material(
    () => ActivityVideoScreen(),
    orientation: RouteConfigOrientation.landscape,
  );

  @override
  Widget build(BuildContext context) {
    final args = context.routeArgs<ActivityVideoScreenArgs>()!;
    return HookBuilder(
      builder: (context) {
        final state = useActivityVideoScreenState(args: args);
        return ActivityVideoScreenView(state: state);
      },
    );
  }
}
