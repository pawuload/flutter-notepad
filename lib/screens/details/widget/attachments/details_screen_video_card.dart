import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/attachments/details_screen_video_player.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailsScreenVideoCard extends StatelessWidget {
  final Note note;
  final DetailsScreenState state;

  const DetailsScreenVideoCard({Key? key, required this.note, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.grey[400],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () => _showVideo(context),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                note.details.thumbnail!,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object object, stackTrace) {
                  return _buildErrorBuilder();
                },
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      color: Colors.grey[100],
                    ),
                  );
                },
              ),
              _buildPlayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return const Center(
      child: Material(
        elevation: 1,
        color: Colors.transparent,
        shape: CircleBorder(side: BorderSide(color: Colors.white)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 32,
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

  Widget _buildErrorBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.brown.shade300,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: const Text(
            "Loading failed",
          ),
        )
      ],
    );
  }
}
