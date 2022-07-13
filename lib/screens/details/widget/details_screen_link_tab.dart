import 'package:app/models/note/note.dart';
import 'package:app/screens/details/widget/details_screen_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class DetailsScreenLinkTab extends StatelessWidget {
  final Note note;

  const DetailsScreenLinkTab({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String linkText = note.details.url!.length > 38 ? note.details.url!.substring(0, 38) + '...' : note.details.url!;

    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.7,
            color: Colors.brown,
          ),
        ),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () => DetailsScreenBottomSheet.show(context, note.details.url!),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: Linkify(
              text: linkText,
              maxLines: 1,
              style: const TextStyle(fontSize: 19),
            ),
          ),
        ),
      ),
    );
  }
}
