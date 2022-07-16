import 'package:app/common/widget/video_player/state/video_player_state.dart';
import 'package:app/screens/video/activity_video_screen_args.dart';

class ActivityVideoScreenState {
  final VideoPlayerState videoPlayerState;
  final String videoUrl;

  // final String thumbNail;

  const ActivityVideoScreenState({
    required this.videoPlayerState,
    required this.videoUrl,
    // required this.thumbNail,
  });
}

ActivityVideoScreenState useActivityVideoScreenState({required ActivityVideoScreenArgs args}) {
  final videoPlayerState = useVideoPlayerState(
    videoPath: args.videoUrl,
    autoplay: true,
    mute: false,
    isFullscreen: true,
  );

  return ActivityVideoScreenState(
    videoPlayerState: videoPlayerState,
    // thumbNail: args.thumbNail,
    videoUrl: args.videoUrl,
  );
}
