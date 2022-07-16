import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/attachments/details_screen_image_cards.dart';
import 'package:app/screens/details/widget/attachments/details_screen_video_card.dart';
import 'package:flutter/material.dart';

class DetailsScreenGallery extends StatelessWidget {
  final DetailsScreenState state;
  final Note note;
  final bool imageExists;
  final bool videoExists;

  const DetailsScreenGallery({
    Key? key,
    required this.state,
    required this.note,
    required this.imageExists,
    required this.videoExists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final int length = videoExists ? note.details.imageUrl!.length + 1 : note.details.imageUrl!.length;
        final int rowCount = length <= 3 ? length : 3;
        final double sizeCrossAxisExtent = (constrains.maxWidth / rowCount) * 0.95;
        final double height = length <= 3 ? sizeCrossAxisExtent : sizeCrossAxisExtent * 2;
        final bool showScrollbar = length > 6;
        final NeverScrollableScrollPhysics? scrollOn = length <= 6 ? const NeverScrollableScrollPhysics() : null;
        final ScrollController _controller = ScrollController();

        return Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 25),
          height: height,
          child: RawScrollbar(
            controller: _controller,
            crossAxisMargin: -12,
            thickness: 7,
            radius: const Radius.circular(20),
            thumbColor: Colors.brown.withOpacity(0.4),
            isAlwaysShown: showScrollbar,
            child: GridView.builder(
              controller: _controller,
              physics: scrollOn,
              scrollDirection: Axis.horizontal,
              itemCount: length,
              itemBuilder: (context, index) {
                if (videoExists) {
                  return SizedBox(
                    child: index == 0
                        ? DetailsScreenVideoCard(note: note, state: state)
                        : DetailsScreenImageCards(image: note.details.imageUrl![index - 1]),
                  );
                } else {
                  return DetailsScreenImageCards(image: note.details.imageUrl![index]);
                }
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: sizeCrossAxisExtent,
                crossAxisSpacing: 1,
                mainAxisSpacing: 3,
              ),
            ),
          ),
        );
      },
    );
  }
}
