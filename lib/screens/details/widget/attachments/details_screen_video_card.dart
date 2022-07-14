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
    final double horizontalMargin = MediaQuery.of(context).size.width * 0.25;
    return Card(
      margin: EdgeInsets.fromLTRB(horizontalMargin, 10, horizontalMargin, 20),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.grey[100],
      child: InkWell(
        onTap: () => _showVideo(context),
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
    );
  }

  Future<void> _showVideo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 700),
            child: DetailsScreenVideoPlayer(state: state, note: state.note),
          ),
        );
      },
    );
  }
}
