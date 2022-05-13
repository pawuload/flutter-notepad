import 'package:app/common/constans/app_icons.dart';
import 'package:app/common/widget/app_nav_bar.dart';
import 'package:app/models/note/note.dart';
import 'package:app/screens/details_screen/state/details_screen_state.dart';
import 'package:app/screens/details_screen/widget/details_screen_button.dart';
import 'package:app/screens/details_screen/widget/details_screen_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DetailsScreen extends HookWidget {
  final Note note;

  const DetailsScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useDetailsScreenState(note: note);

    return WillPopScope(
      onWillPop: () async {
        if (state.isReadOnlyState == false) {
          final result = await showExitDialog(context);
          if (result) {
            state.switchReadOnly();
            return false;
          } else {
            return false;
          }
        } else {
          return true;
        }
      },
      child: Scaffold(
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
                      maxLines: 1000,
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
          child: DetailsScreenButton(state: state),
        ),
        floatingActionButtonLocation:
            state.isReadOnlyState ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: state.isReadOnlyState
            ? null
            : AppNavBar(
                state: state,
                exitFunction: () => state.switchReadOnly(),
              ),
      ),
    );
  }
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
