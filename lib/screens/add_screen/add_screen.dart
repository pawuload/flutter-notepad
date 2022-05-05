import 'package:app/screens/add_screen/state/add_screen_state.dart';
import 'package:app/screens/add_screen/widget/add_screen_button.dart';
import 'package:app/screens/add_screen/widget/add_screen_nav_bar.dart';
import 'package:app/screens/add_screen/widget/add_screen_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddScreen extends HookWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useAddScreenState();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 60,
              child: AddScreenTextField(
                state: state.titleState,
                fontSize: 20,
                limit: 47,
                hint: 'Title',
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AddScreenTextField(
                    state: state.descriptionState,
                    maxLines: 100,
                    fontSize: 16,
                    hint: 'Start your note here...',
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
        child: const AddScreenButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AddScreenNavBar(state: state),
    );
  }
}
