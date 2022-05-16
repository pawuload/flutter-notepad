import 'package:app/common/constans/app_icons.dart';
import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/details_screen_bottom_sheet.dart';
import 'package:flutter/material.dart';

class DetailsScreenAttachments extends StatelessWidget {
  final DetailsScreenState state;
  final Note note;

  const DetailsScreenAttachments({Key? key, required this.state, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ((note.details.url != '' || note.details.imageUrl != null) && state.isReadOnly == true)
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
            margin: const EdgeInsets.fromLTRB(3, 2, 3, 16),
            constraints: const BoxConstraints(maxHeight: 550),
            child: Image.network(note.details.imageUrl!),
          ),
      ],
    );
  }
}
