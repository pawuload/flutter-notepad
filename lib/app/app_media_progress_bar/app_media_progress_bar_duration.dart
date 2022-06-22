import 'package:app/app/app_media_progress_bar/duration_extension.dart';
import 'package:flutter/material.dart';

class AppMediaProgressBarDuration extends StatelessWidget {
  final Duration duration;

  const AppMediaProgressBarDuration({
    Key? key,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: Text(
        duration.toMMSS,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
