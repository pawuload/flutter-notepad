import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailsScreenImages extends StatelessWidget {
  final DetailsScreenState state;
  final Note note;

  const DetailsScreenImages({Key? key, required this.state, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, note.details.videoUrl == null ? 55 : 12),
      height: note.details.imageUrl!.length <= 3
          ? 150
          : note.details.imageUrl!.length <= 6
              ? 260
              : 290,
      width: double.infinity,
      child: GridView.builder(
        itemCount: note.details.imageUrl!.length,
        itemBuilder: (context, index) {
          return _buildCardsWithGestureDetector(context, note.details.imageUrl![index]);
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: 1,
          mainAxisSpacing: 3,
        ),
      ),
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
      ),
    );
  }

  Widget _buildErrorBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.brown.shade400,
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
