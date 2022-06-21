import 'package:app/models/note/note.dart';
import 'package:app/screens/details/widget/details_screen_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DetailsScreenLinkTab extends StatelessWidget {
  final Note note;
  const DetailsScreenLinkTab({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
