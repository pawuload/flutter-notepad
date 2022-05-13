import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:app/common/widget/navigation_bar/app_nav_bar.dart';
import 'package:app/screens/add_screen/state/add_screen_state.dart';
import 'package:app/screens/add_screen/widget/add_screen_button.dart';
import 'package:app/common/widget/textfield/note_textfield/note_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddScreen extends HookWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useAddScreenState();

    return WillPopScope(
      onWillPop: () async {
        final result = await AppAlertDialog.showExit(context);
        if (result == true) {
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        body: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: NoteTextField(
                    isReadOnly: state.isReadOnlyState,
                    state: state.titleState,
                    fontSize: 20,
                    limit: 47,
                    hint: 'Title',
                    showBorder: true,
                    maxLines: 1,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: NoteTextField(
                        onTap: () async {
                          if (!state.userState.user!.details.isPremium) {
                            state.timer();
                            Future.delayed(
                              const Duration(seconds: 45),
                              () async {
                                state.switchReadOnly();
                                final result = await AppAlertDialog.showPremium(
                                  context,
                                  title: 'Buy Premium version and have unlimited time!',
                                  description:
                                      'Get the Premium version to unlock an unlimited time for writing your notes!',
                                  button: 'GET IT NOW',
                                );
                                if (result == true) {
                                  state.switchReadOnly();
                                  state.switchPremium();
                                  state.userState.refresh();
                                }
                              },
                            );
                          }
                        },
                        isReadOnly: state.isReadOnlyState,
                        state: state.descriptionState,
                        maxLines: 50,
                        fontSize: 16,
                        hint: 'Start your note here...',
                        showBorder: false,
                      ),
                    ),
                  ),
                ),
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
          onSavePressed: state.onSaveButtonPressed,
          onExitPressed: () => Navigator.pop(context, false),
        ),
      ),
    );
  }
}
