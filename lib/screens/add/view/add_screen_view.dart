import 'package:app/common/widget/navigation_bar/app_nav_bar.dart';
import 'package:app/common/widget/textfield/note_textfield/note_textfield.dart';
import 'package:app/screens/add/state/add_screen_state.dart';
import 'package:app/screens/add/widget/add_screen_button.dart';
import 'package:app/screens/add/widget/add_screen_url.dart';
import 'package:flutter/material.dart';

class AddScreenView extends StatelessWidget {
  final AddScreenState state;

  const AddScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => state.onWillPop(),
      child: Scaffold(
        body: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                _buildNoteTextFieldTitle(),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildNoteTextFieldDescription(),
                  ),
                ),
                if (state.isLinkTabOpen == true) AddScreenUrl(state: state),
              ],
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: AddScreenButton(state: state),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppNavBar(
          onLinkPressed: state.onLinkPressed,
          onSavePressed: state.onSaveButtonPressed,
          onExitPressed: state.onExitPressed,
          onImagePressed: state.onPickImagePressed,
        ),
      ),
    );
  }

  Widget _buildNoteTextFieldTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: NoteTextField(
        isReadOnly: state.isReadOnly,
        state: state.titleState,
        fontSize: 20,
        limit: 47,
        hint: 'Title',
        showBorder: true,
        maxLines: 1,
      ),
    );
  }

  Widget _buildNoteTextFieldDescription() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: NoteTextField(
        isReadOnly: state.isReadOnly,
        state: state.descriptionState,
        maxLines: 32,
        fontSize: 16,
        hint: 'Start your note here...',
        showBorder: false,
      ),
    );
  }
}