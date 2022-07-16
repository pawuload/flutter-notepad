import 'package:app/common/widget/activity_video/widget/activity_full_screen_header.dart';
import 'package:app/common/widget/activity_video/widget/activity_full_screen_layout.dart';
import 'package:app/common/widget/video_player/app_video_player_content.dart';
import 'package:app/common/widget/video_player/state/video_player_state.dart';
import 'package:app/common/widget/video_player/widgets/app_video_player_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ActivityVideoContentView extends HookWidget {
  final VideoPlayerState videoPlayerState;
  final String videoUrl;
  final String thumbNail;
  final Color loadingColor;
  final Color loadingBackgroundColor;
  final Color bottomControlsProgressColor;

  const ActivityVideoContentView({
    Key? key,
    required this.videoPlayerState,
    required this.videoUrl,
    required this.thumbNail,
    required this.loadingColor,
    required this.loadingBackgroundColor,
    required this.bottomControlsProgressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActivityFullScreenLayout(
      backgroundImage: thumbNail,
      landscapeBuilder: (_, constraints) => _buildLandscape(constraints),
      portraitBuilder: (_, constraints) => _buildPortrait(constraints),
    );
  }

  Widget _buildPortrait(BoxConstraints constraints) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: constraints.maxWidth,
              child: _buildVideoPlayer(),
            ),
          ),
        ),
        Positioned.fill(child: _buildBackground()),
        Align(
          alignment: Alignment.topCenter,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: _buildControls(),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscape(BoxConstraints constraints) {
    return Stack(
      children: [
        Positioned.fill(child: _buildBackground()),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: constraints.maxHeight,
            child: _buildVideoPlayer(),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: _buildControls(),
          ),
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return IgnorePointer(
      ignoring: false,
      child: AnimatedOpacity(
        opacity: videoPlayerState.areControlsVisible ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Container(color: Colors.black.withOpacity(0.5)),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return GestureDetector(
      onTap: () => videoPlayerState.toggleControlsVisibility(),
      child: AppVideoPlayerContent(
        state: videoPlayerState,
        isAsset: false,
        aspectRatio: 16 / 9,
        thumbnail: thumbNail,
        loadingBackgroundColor: loadingBackgroundColor,
        loadingColor: loadingColor,
      ),
    );
  }

  Widget _buildControls() {
    return SafeArea(
      child: IgnorePointer(
        ignoring: false,
        child: AppVideoPlayerControls(
          state: videoPlayerState,
          isBottomBarTransparent: false,
          header: const ActivityFullscreenHeader(),
          bottomControlsProgressColor: bottomControlsProgressColor,
        ),
      ),
    );
  }
}
