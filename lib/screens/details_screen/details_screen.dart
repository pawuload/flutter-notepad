import 'package:app/models/note/note.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/screens/details_screen/state/details_screen_state.dart';
import 'package:app/screens/details_screen/widget/details_screen_button.dart';
import 'package:app/screens/details_screen/widget/details_screen_nav_bar.dart';
import 'package:app/screens/details_screen/widget/details_screen_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DetailsScreen extends HookWidget {
  final Note note;
  final UserState user;

  const DetailsScreen({
    Key? key,
    required this.note,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useDetailsScreenState(note: note);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DetailsScreenTextField(
                isReadOnly: state.isReadOnlyState,
                state: state.titleFieldState,
                fontSize: 20,
                maxLines: 1,
                limit: 47,
                showBorder: true,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: DetailsScreenTextField(
                    isReadOnly: state.isReadOnlyState,
                    state: state.descriptionFieldState,
                    maxLines: 50,
                    fontSize: 16,
                    showBorder: false,
                  ),
                ),
              ),
            ),
            // const AddScreenUrl(),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: DetailsScreenButton(state: state, user: user),
      ),
      floatingActionButtonLocation: state.isReadOnlyState ? FloatingActionButtonLocation.endFloat: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: state.isReadOnlyState ? null : DetailsScreenNavBar(state: state),
    );
  }
}
