import 'package:app/screens/video/activity_video_screen_args.dart';
import 'package:app/screens/video/state/activity_video_screen_state.dart';
import 'package:app/screens/video/view/activity_video_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_utils/utopia_utils.dart';

class ActivityVideoScreen extends HookWidget {
  static const route = '/video';
  static final routeConfig = RouteConfig.material(() => const ActivityVideoScreen());

  const ActivityVideoScreen({Key? key}) : super(key: key);

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
