import 'package:app/common/widget/video_player/state/use_video_player_state.dart';
import 'package:app/common/widget/video_player/widgets/app_video_player_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

const _autoHideDuration = Duration(seconds: 1);

class AppVideoPlayerControls extends HookWidget {
  final VideoPlayerState state;
  final Color bottomControlsProgressColor;
  final Widget? header;
  final bool isBottomBarTransparent;

  const AppVideoPlayerControls({
    Key ? key,
    required this.state,
    required this.bottomControlsProgressColor,
    this.header,
    this.isBottomBarTransparent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: _autoHideDuration);
    useAsyncEffect(() async {
      if (state.areControlsVisible) {
        animationController.forward(from: 0);
      } else if (state.isFinished) {
        state.toggleControlsVisibility();
      }
    }, [state.isPlaying, state.isFinished]);
    useAsyncEffect(() async {
      if (animationController.value == 1 && state.isPlaying && state.areControlsVisible && !state.isFinished) {
        state.toggleControlsVisibility();
      }
    }, [animationController.value]);
    return GestureDetector(
      onTap: () => state.toggleControlsVisibility(),
      child: AnimatedOpacity(
        opacity: state.areControlsVisible ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              child: _buildPlayPauseButton(),
            ),
            AppVideoPlayerBottomBar(
              state: state,
              isBackgroundTransparent: isBottomBarTransparent,
              progressColor: bottomControlsProgressColor,
            ),
            if (header != null)
              Align(
                alignment: Alignment.topCenter,
                child: AbsorbPointer(
                  absorbing: !state.areControlsVisible,
                  child: header,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    final icon = state.isFinished
        ? Icons.refresh_rounded
        : state.isPlaying
            ? Icons.pause
            : Icons.play_arrow;

    return Center(
      child: GestureDetector(
        onTap: () => state.areControlsVisible
            ? state.isFinished
                ? state.repeat()
                : state.togglePlaying()
            : state.toggleControlsVisibility(),
        child: Material(
          elevation: 1,
          color: Colors.transparent,
          shape: const CircleBorder(side: BorderSide(color: Colors.white)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
