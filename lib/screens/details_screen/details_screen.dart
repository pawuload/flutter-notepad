import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:app/common/widget/navigation_bar/app_nav_bar.dart';
import 'package:app/models/note/note.dart';
import 'package:app/screens/details_screen/state/details_screen_state.dart';
import 'package:app/screens/details_screen/widget/details_screen_bottom_sheet.dart';
import 'package:app/screens/details_screen/widget/details_screen_button.dart';
import 'package:app/screens/details_screen/widget/details_screen_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

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
          final result = await AppAlertDialog.showExit(context);
          if (result == true) {
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
                      maxLines: 25,
                      fontSize: 16,
                      showBorder: false,
                    ),
                  ),
                ),
              ),
              if(note.details.url != '')
                Linkify(
                  onOpen: (_) => DetailsScreenBottomSheet.show(context, note.details.url!),
                  text: note.details.url!,
                ),

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
                onSavePressed: state.onSaveButtonPressed,
                onExitPressed: state.switchReadOnly,
                onImagePressed: state.onPickImagePressed,
              ),
      ),
    );
  }
}
