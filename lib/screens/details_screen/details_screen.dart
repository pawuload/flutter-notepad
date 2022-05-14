import 'package:app/common/constans/app_icons.dart';
import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:app/common/widget/navigation_bar/app_nav_bar.dart';
import 'package:app/models/note/note.dart';
import 'package:app/screens/details_screen/state/details_screen_state.dart';
import 'package:app/screens/details_screen/widget/details_screen_bottom_sheet.dart';
import 'package:app/screens/details_screen/widget/details_screen_button.dart';
import 'package:app/screens/details_screen/widget/details_screen_textfield.dart';
import 'package:app/screens/details_screen/widget/details_screen_url.dart';
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
              _buildDetailsScreenTextFieldTitle(
                isReadOnly: state.isReadOnlyState,
                titleFieldState: state.titleFieldState,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildDetailsScreenTextFieldDescription(
                    isReadOnly: state.isReadOnlyState,
                    descriptionFieldState: state.descriptionFieldState,
                  ),
                ),
              ),
              _buildAttachments(state: state, note: note, context: context),
              if (state.isLinkTabOpen == true)
                if (state.isReadOnlyState == false) DetailsScreenUrl(state: state),
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
                onLinkPressed: state.onLinkPressed,
                onSavePressed: state.onSaveButtonPressed,
                onExitPressed: state.switchReadOnly,
                onImagePressed: state.onPickImagePressed,
              ),
      ),
    );
  }
}

Widget _buildDetailsScreenTextFieldTitle({required isReadOnly, required titleFieldState}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: DetailsScreenTextField(
      isReadOnly: isReadOnly,
      state: titleFieldState,
      fontSize: 20,
      maxLines: 1,
      limit: 47,
      showBorder: true,
    ),
  );
}

Widget _buildDetailsScreenTextFieldDescription({required isReadOnly, required descriptionFieldState}) {
  return Padding(
    padding: const EdgeInsets.all(7),
    child: DetailsScreenTextField(
      isReadOnly: isReadOnly,
      state: descriptionFieldState,
      maxLines: 25,
      fontSize: 16,
      showBorder: false,
    ),
  );
}

Widget _buildAttachments({required state, required note, required context}) {
  return Column(
    children: [
      if ((note.details.url != '' || note.details.imageUrl != null) && state.isReadOnlyState == true)
        IconButton(
          icon: Icon(
            state.isTabOpen == true ? AppIcons.down : AppIcons.up,
            size: 30,
          ),
          onPressed: state.onTabOpenPressed,
        ),
      if (state.isTabOpen == true && note.details.url != null && state.isReadOnlyState == true)
        Container(
          padding: const EdgeInsets.fromLTRB(4, 3, 4, 3),
          margin: const EdgeInsets.fromLTRB(6, 2, 6, 17),
          child: GestureDetector(
            onTap: () => DetailsScreenBottomSheet.show(context, note.details.url!),
            child: Text(
              note.details.url.length > 36 ? note.details.url.substring(0, 36) + '...' : note.details.url,
              maxLines: 1,
              style: const TextStyle(fontSize: 17),
            ),
          ),
        ),
      if (state.isTabOpen == true && note.details.imageUrl != null && state.isReadOnlyState == true)
        Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 16),
          constraints: const BoxConstraints(maxHeight: 625),
          child: Image.network(note.details.imageUrl!),
        ),
    ],
  );
}
