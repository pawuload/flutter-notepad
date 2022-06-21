import 'package:app/common/widget/video_player/app_video_player.dart';
import 'package:app/models/note/note.dart';
import 'package:flutter/material.dart';

class DetailsScreenVideoPlayer extends StatelessWidget {
  final Note note;

  const DetailsScreenVideoPlayer({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 75),
      child: AppVideoPlayer(
        aspectRatio: 1.75,
        videoPath: note.details.videoUrl!,
        bottomControlsProgressColor: Colors.white,
        loadingBackgroundColor: Colors.brown.shade300,
        loadingColor: Colors.white,
      ),
    );
  }
}
