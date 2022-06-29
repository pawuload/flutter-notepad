import 'package:app/app/app_media_progress_bar/app_media_progress_bar.dart';
import 'package:app/common/widget/video_player/state/use_video_player_state.dart';
import 'package:app/common/widget/video_player/widgets/app_video_player_button.dart';
import 'package:flutter/material.dart';

class AppVideoPlayerBottomBar extends StatelessWidget {
  final VideoPlayerState state;
  final Color progressColor;
  final bool isBackgroundTransparent;

  const AppVideoPlayerBottomBar({
    Key? key,
    required this.state,
    required this.progressColor,
    this.isBackgroundTransparent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: _buildBarDecoration(),
      child: Row(
        children: [
          Expanded(
            child: AppMediaProgressBar(
              progress: Duration(milliseconds: state.progress),
              total: state.controller != null ? state.controller!.value.duration : Duration.zero,
              onSeek: (time) => state.areControlsVisible ? state.seekTo(time.inMilliseconds) : null,
              progressColor: progressColor,
            ),
          ),
          AppVideoPlayerButton(
            icon: state.isSound ? Icons.volume_down_sharp : Icons.volume_off_rounded,
            onTap: state.toggleVolume,
          ),
          AppVideoPlayerButton(
            icon: state.isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
            onTap: state.toggleFullscreen,
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBarDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          isBackgroundTransparent ? Colors.transparent : Colors.black.withOpacity(0.72),
        ],
      ),
    );
  }
}
