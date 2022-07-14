import 'package:app/common/widget/textfield/note_textfield/note_textfield.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:flutter/material.dart';

class DetailsScreenUrl extends StatelessWidget {
  final DetailsScreenState state;

  const DetailsScreenUrl({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.4,
            color: Colors.brown,
          ),
        ),
      ),
      child: _buildUrl(),
    );
  }

  Widget _buildUrl() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      child: NoteTextField(
        state: state.urlFieldState,
        isReadOnly: state.isReadOnly,
        hint: 'https://...',
        fontSize: 16,
        maxLines: 1,
        showBorder: false,
      ),
    );
  }
}
