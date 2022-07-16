import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailsScreenImageCards extends StatelessWidget {
  final String image;

  const DetailsScreenImageCards({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCardsWithInkWell(context, image);
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
          color: Colors.brown.shade300,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: const Text("Loading failed"),
        )
      ],
    );
  }

  Widget _buildCardsWithInkWell(BuildContext context, String image) {
    return InkWell(
      onTap: () => _showImage(context, image),
      child: _buildCard(image: image),
    );
  }

  Future<void> _showImage(BuildContext context, String image) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 700),
              child: _buildCard(image: image),
            ),
          ),
        );
      },
    );
  }
}
