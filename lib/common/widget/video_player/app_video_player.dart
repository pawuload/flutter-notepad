import 'package:app/common/widget/video_player/app_video_player_content.dart';
import 'package:app/common/widget/video_player/state/video_player_state.dart';
import 'package:app/common/widget/video_player/widgets/app_video_player_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppVideoPlayer extends HookWidget {
  final String videoPath;
  final String? thumbnail;
  final bool looping;
  final bool showControls;
  final bool autoplay;
  final bool isInView;
  final bool mute;
  final bool isFullscreen;
  final double? aspectRatio;
  final Color bottomControlsProgressColor;
  final Color loadingBackgroundColor;
  final Color loadingColor;
  final Function(bool)? onTogglePlay;
  final Function(String, String)? navigateToFullScreen;
  final Widget Function(VideoPlayerState)? controls;

  AppVideoPlayer({
    this.looping = false,
    this.autoplay = false,
    required this.videoPath,
    required this.bottomControlsProgressColor,
    required this.loadingBackgroundColor,
    required this.loadingColor,
    required this.navigateToFullScreen,
    this.thumbnail,
    this.showControls = true,
    this.isInView = true,
    this.onTogglePlay,
    this.aspectRatio,
    this.mute = true,
    this.controls,
    this.isFullscreen = false,
  }) : super(key: ValueKey(videoPath));

  @override
  Widget build(BuildContext context) {
    final state = useVideoPlayerState(
      navigateToFullScreen: (videoUrl, thumbNail) => navigateToFullScreen?.call(videoUrl, thumbNail),
      videoPath: videoPath,
      looping: looping,
      autoplay: autoplay,
      isInView: isInView,
      mute: mute,
      onTogglePlay: onTogglePlay,
      isFullscreen: isFullscreen,
      thumbnail: thumbnail,
    );
    return Focus(
      focusNode: state.focusNode,
      child: Stack(
        children: [
          AppVideoPlayerContent(
            isAsset: false,
            state: state,
            aspectRatio: aspectRatio,
            thumbnail: thumbnail,
            loadingBackgroundColor: loadingBackgroundColor,
            loadingColor: loadingColor,
          ),
          if (showControls)
            Positioned.fill(
              child: AppVideoPlayerControls(state: state, bottomControlsProgressColor: bottomControlsProgressColor),
            ),
        ],
      ),
    );
  }
}
