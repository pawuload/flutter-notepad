import 'package:app/common/constans/app_icons.dart';
import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/attachments/details_screen_images.dart';
import 'package:app/screens/details/widget/attachments/details_screen_video_card.dart';
import 'package:flutter/material.dart';

class DetailsScreenAttachments extends StatelessWidget {
  final DetailsScreenState state;
  final Note note;

  const DetailsScreenAttachments({Key? key, required this.state, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool imageExists = note.details.imageUrl != null && note.details.imageUrl!.isNotEmpty;
    final bool videoExists = note.details.videoUrl != null && note.details.videoUrl!.isNotEmpty;

    return Container(
      decoration: _buildBoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if ((imageExists || videoExists) && state.isReadOnly) _buildIconButton(),
          _buildAttachments(videoExists, imageExists),
        ],
      ),
    );
  }

  Widget _buildIconButton() {
    return IconButton(
      icon: Icon(
        state.isTabOpen == true ? AppIcons.down : AppIcons.up,
      ),
      alignment: Alignment.center,
      iconSize: 30,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: state.onTabOpenPressed,
      padding: const EdgeInsets.fromLTRB(100, 12, 100, 7),
    );
  }

  Widget _buildAttachments(bool videoExists, bool imageExists) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          if (state.isTabOpen && state.isReadOnly) ...[
            if (videoExists) DetailsScreenVideoCard(note: note, state: state),
            if (imageExists) DetailsScreenImages(state: state, note: note),
            const SizedBox(height: 55),
          ],
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(240, 240, 240, 1.0),
          Color.fromRGBO(255, 255, 255, 1.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 1.0), //(x,y)
          blurRadius: 6.0,
        ),
      ],
    );
  }
}
