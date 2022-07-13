import 'package:app/common/constans/app_icons.dart';
import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/attachments/details_screen_video_player.dart';
import 'package:flutter/material.dart';

class DetailsScreenVideoCard extends StatelessWidget {
  final Note note;
  final DetailsScreenState state;

  const DetailsScreenVideoCard({Key? key, required this.note, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only( bottom: 20, top: 10),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.grey[100],
      child: InkWell(
        onTap: () => _showVideo(context),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Icon(
                AppIcons.playVideo,
                size: 45,
                color: Colors.brown[400],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showVideo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.95,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 700),
              child: DetailsScreenVideoPlayer(state: state, note: state.note),
            ),
          ),
        );
      },
    );
  }
}
