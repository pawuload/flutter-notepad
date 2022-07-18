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
  final bool mute;
  final double? aspectRatio;
  final Color bottomControlsProgressColor;
  final Color loadingBackgroundColor;
  final Color loadingColor;
  final Function(bool)? onTogglePlay;
  final Widget Function(VideoPlayerState)? controls;

  AppVideoPlayer({
    this.looping = false,
    this.autoplay = false,
    required this.videoPath,
    required this.bottomControlsProgressColor,
    required this.loadingBackgroundColor,
    required this.loadingColor,
    this.thumbnail,
    this.showControls = true,
    this.onTogglePlay,
    this.aspectRatio,
    this.mute = true,
    this.controls,
  }) : super(key: ValueKey(videoPath));

  @override
  Widget build(BuildContext context) {
    final state = useVideoPlayerState(
      videoPath: videoPath,
      looping: looping,
      autoplay: autoplay,
      mute: mute,
      onTogglePlay: onTogglePlay,
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
