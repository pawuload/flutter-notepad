import 'package:app/screens/video/state/use_activity_video_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ActivityVideoScreenView extends HookWidget {
  final ActivityVideoScreenState state;

  const ActivityVideoScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ActivityVideoContentView(
    //   videoUrl: state.videoUrl,
    //   thumbNail: state.thumbNail,
    //   videoPlayerState: state.videoPlayerState,
    //   bottomControlsProgressColor: Colors.white,
    //   loadingBackgroundColor: Colors.brown.shade300,
    //   loadingColor: Colors.white,
    // );
    return Container();
  }
}
