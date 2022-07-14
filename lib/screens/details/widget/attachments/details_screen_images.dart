import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/attachments/details_screen_image_cards.dart';
import 'package:flutter/material.dart';

class DetailsScreenImages extends StatelessWidget {
  final DetailsScreenState state;
  final Note note;

  const DetailsScreenImages({Key? key, required this.state, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final int length = note.details.imageUrl!.length;
      final int rowCount = length  <= 3 ? length  : 3;
      final double sizeCrossAxisExtent = (constrains.maxWidth / rowCount) * 0.95;
      final double size = length  <= 3 ? sizeCrossAxisExtent : sizeCrossAxisExtent * 2;
      final bool showScrollbar = length  > 6;
      final NeverScrollableScrollPhysics? scrollOn = length  <= 6 ? const NeverScrollableScrollPhysics() : null;
      final ScrollController _controller = ScrollController();

      return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 25),
        height: size,
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
            itemCount: note.details.imageUrl!.length,
            itemBuilder: (context, index) => DetailsScreenImageCards(image: note.details.imageUrl![index]),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: sizeCrossAxisExtent,
              crossAxisSpacing: 1,
              mainAxisSpacing: 3,
            ),
          ),
        ),
      );
    });
  }
}
