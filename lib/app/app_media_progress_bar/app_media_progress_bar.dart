import 'package:app/app/app_media_progress_bar/app_media_progress_bar_duration.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class AppMediaProgressBar extends StatelessWidget {
  final Color progressColor;
  final Duration progress;
  final Duration? buffered;
  final Duration total;
  final Function(Duration)? onSeek;
  final Function()? onDragStart;
  final Function()? onDragUpdate;
  final Function()? onDragEnd;

  const AppMediaProgressBar({
    Key? key,
    required this.progressColor,
    required this.progress,
    required this.total,
    this.buffered,
    this.onSeek,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppMediaProgressBarDuration(duration: progress),
        _buildProgressBar(),
        AppMediaProgressBarDuration(duration: total),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Expanded(
      child: ProgressBar(
        progress: progress,
        buffered: buffered,
        total: total,
        progressBarColor: progressColor,
        baseBarColor: Colors.white.withOpacity(0.47),
        bufferedBarColor: Colors.white.withOpacity(0.24),
        thumbColor: Colors.white,
        barHeight: 4,
        thumbRadius: 5,
        thumbGlowRadius: 5,
        timeLabelLocation: TimeLabelLocation.none,
        onSeek: onSeek,
        onDragStart: (_) => onDragStart?.call(),
        onDragUpdate: (_) => onDragUpdate?.call(),
        onDragEnd: () => onDragEnd?.call(),
      ),
    );
  }
}
