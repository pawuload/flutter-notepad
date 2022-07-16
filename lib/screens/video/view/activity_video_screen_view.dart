import 'package:app/common/widget/activity_video/activity_video_content_view.dart';
import 'package:app/screens/video/state/activity_video_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';
import 'package:wakelock/wakelock.dart';

class ActivityVideoScreenView extends HookWidget {
  final ActivityVideoScreenState state;

  const ActivityVideoScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.navigator.pop();
        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        await Wakelock.toggle(enable: false);
        return false;
      },
      child: ActivityVideoContentView(
        videoUrl: state.videoUrl,
        thumbNail: state.thumbNail,
        videoPlayerState: state.videoPlayerState,
        bottomControlsProgressColor: Colors.white,
        loadingBackgroundColor: Colors.brown.shade300,
        loadingColor: Colors.white,
      ),
    );
  }
}
