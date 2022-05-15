import 'package:app/common/widget/textfield/note_textfield/note_textfield.dart';
import 'package:app/screens/add/state/add_screen_state.dart';
import 'package:flutter/material.dart';

class AddScreenUrl extends StatelessWidget {
  final AddScreenState state;

  const AddScreenUrl({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(
          width: 0.4,
          color: Colors.brown,
        ),
      )),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        child: NoteTextField(
          state: state.urlState,
          hint: 'https://...',
          isReadOnly: state.isReadOnly,
          fontSize: 16,
          maxLines: 1,
          showBorder: false,
        ),
      ),
    );
  }
}
