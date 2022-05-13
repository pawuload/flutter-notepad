import 'package:app/common/constans/app_color.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:app/common/widget/app_nav_bar.dart';
import 'package:app/screens/add_screen/state/add_screen_state.dart';
import 'package:app/screens/add_screen/widget/add_screen_button.dart';
import 'package:app/common/widget/note_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddScreen extends HookWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useAddScreenState();

    return WillPopScope(
      onWillPop: () async {
        final result = await showExitDialog(context);
        if (result) {
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
                                final result = await showPremiumDialog(
                                  context,
                                  'Buy Premium version and have unlimited time!',
                                  'Get the Premium version to unlock an unlimited time for writing your notes!',
                                  'GET IT NOW',
                                );
                                if (result) {
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
          state: state,
          exitFunction: () => Navigator.pop(context, false),
        ),
      ),
    );
  }
}

Future<bool> showPremiumDialog(BuildContext context, String text, String descriptionText, String buttonText) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            descriptionText,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
      actions: <Widget>[
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: AppColors.premium, elevation: 10),
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Future<bool> showExitDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text(
        'Are you sure you want to exit?',
        style: TextStyle(fontSize: 16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "If you press 'ok' your notes are not going to be saved.",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(
              AppIcons.yes,
              color: Colors.brown,
              size: 40,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: const Icon(
              AppIcons.no,
              color: Colors.brown,
              size: 40,
            ),
          ),
        ),
      ],
    ),
  );
}
