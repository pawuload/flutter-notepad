import 'package:app/common/constans/app_icons.dart';
import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/details_screen_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class DetailsScreenAttachments extends StatelessWidget {
  final DetailsScreenState state;
  final Note note;

  const DetailsScreenAttachments({Key? key, required this.state, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ((note.details.url != '' || note.details.imageUrl != null || note.details.videoUrl != null) && state.isReadOnly == true)
          IconButton(
            icon: Icon(
              state.isTabOpen == true ? AppIcons.down : AppIcons.up,
              size: 30,
            ),
            onPressed: state.onTabOpenPressed,
          ),
        if (state.isTabOpen == true && note.details.url != null && state.isReadOnly == true)
          Container(
            padding: const EdgeInsets.fromLTRB(4, 3, 4, 3),
            margin: const EdgeInsets.fromLTRB(6, 2, 6, 17),
            child: GestureDetector(
              onTap: () => DetailsScreenBottomSheet.show(context, note.details.url!),
              child: Text(
                note.details.url!.length > 36 ? note.details.url!.substring(0, 36) + '...' : note.details.url!,
                maxLines: 1,
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ),
        if (state.isTabOpen == true && note.details.imageUrl != null && state.isReadOnly == true)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 195,
            width: double.infinity,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                _buildCardsWithGestureDetector(context, note.details.imageUrl!),
                _buildCardsWithGestureDetector(context, note.details.imageUrl!),
                _buildCardsWithGestureDetector(context, note.details.imageUrl!),
              ],
            ),
          ),
        if (state.isTabOpen == true && note.details.videoUrl != null && state.isReadOnly == true)
          Container(
            //TODO
            child: Text(state.note.details.videoUrl!),
          ),
      ],
    );
  }

  Widget _buildCard({required String image}) {
    return Card(
      elevation: 5,
      color: Colors.grey[400],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          image,
          fit: BoxFit.cover,
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
      ),
    );
  }

  Widget _buildCardsWithGestureDetector(BuildContext context, String image) {
    return GestureDetector(
      onTap: () {
        _showDialog(context, image);
      },
      child: _buildCard(image: image),
    );
  }

  _showDialog(BuildContext context, String image) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Container(
              padding: const EdgeInsets.all(15),
              constraints: const BoxConstraints(maxHeight: 700),
              child: _buildCard(image: image),
            ),
          ),
        );
      },
    );
  }
}
