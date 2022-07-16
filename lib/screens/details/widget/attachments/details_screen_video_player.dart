import 'package:app/common/widget/video_player/app_video_player.dart';
import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:flutter/material.dart';

class DetailsScreenVideoPlayer extends StatelessWidget {
  final Note note;
  final DetailsScreenState state;

  const DetailsScreenVideoPlayer({Key? key, required this.note, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AppVideoPlayer(
        videoPath: note.details.videoUrl!,
        bottomControlsProgressColor: Colors.white,
        loadingBackgroundColor: Colors.brown.shade300,
        loadingColor: Colors.white,
        autoplay: false,
        // navigateToFullScreen: state.navigateToFullScreen(note.details.videoUrl!, note.details.thumbnail!),
      ),
    );
  }
}
