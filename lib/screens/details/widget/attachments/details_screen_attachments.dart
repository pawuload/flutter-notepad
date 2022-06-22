import 'package:app/common/constans/app_icons.dart';
import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/attachments/details_screen_images.dart';
import 'package:app/screens/details/widget/attachments/details_screen_link_tab.dart';
import 'package:app/screens/details/widget/attachments/details_screen_video_player.dart';
import 'package:flutter/material.dart';

class DetailsScreenAttachments extends StatelessWidget {
  final DetailsScreenState state;
  final Note note;

  const DetailsScreenAttachments({Key? key, required this.state, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ((note.details.url != '' || note.details.imageUrl!.isEmpty == false || note.details.videoUrl != null) &&
            state.isReadOnly == true)
          IconButton(
            icon: Icon(
              state.isTabOpen == true ? AppIcons.down : AppIcons.up,
              size: 30,
            ),
            onPressed: state.onTabOpenPressed,
          ),
        if (state.isTabOpen == true && note.details.url != null && state.isReadOnly == true) DetailsScreenLinkTab(note: note),
        if (state.isTabOpen == true && note.details.imageUrl!.isEmpty == false && state.isReadOnly == true)
          DetailsScreenImages(state: state, note: note),
        if (state.isTabOpen == true && note.details.videoUrl != null && state.isReadOnly == true) DetailsScreenVideoPlayer(note: note),
      ],
    );
  }
}
