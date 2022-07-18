import 'package:app/common/widget/navigation_bar/app_nav_bar.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/attachments/details_screen_attachments.dart';
import 'package:app/screens/details/widget/details_screen_button.dart';
import 'package:app/screens/details/widget/details_screen_link_tab.dart';
import 'package:app/screens/details/widget/details_screen_textfield.dart';
import 'package:app/screens/details/widget/details_screen_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailsScreenView extends StatelessWidget {
  final DetailsScreenState state;

  const DetailsScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      onWillPop: () => state.onWillPop(),
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            _buildNoteText(),
            Align(
              alignment: Alignment.bottomCenter,
              child: DetailsScreenAttachments(state: state, note: state.note),
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: DetailsScreenButton(state: state),
        ),
        floatingActionButtonLocation:
            state.isReadOnly ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: state.isReadOnly
            ? null
            : AppNavBar(
                onLinkPressed: state.onLinkPressed,
                onSavePressed: state.onSaveButtonPressed,
                onVideoPressed: state.onVideoPressed,
                onImagePressed: state.onPickImagePressed,
              ),
      ),
    );
  }

  Widget _buildNoteText() {
    final urlExists = state.note.details.url != null && state.note.details.url!.isNotEmpty;
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          _buildDetailsScreenTextFieldTitle(),
          Expanded(
            child: SingleChildScrollView(
              child: _buildDetailsScreenTextFieldDescription(urlExists),
            ),
          ),
          if (state.isReadOnly == false)
            AnimatedOpacity(
                opacity: state.isLinkTabOpen ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: state.isLinkTabOpen == true ? DetailsScreenUrl(state: state) : null),
        ],
      ),
    );
  }

  Widget _buildDetailsScreenTextFieldTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DetailsScreenTextField(
        isReadOnly: state.isReadOnly,
        state: state.titleFieldState,
        fontSize: 20,
        maxLines: 1,
        limit: 47,
        showBorder: true,
      ),
    );
  }

  Widget _buildDetailsScreenTextFieldDescription(bool urlExists) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Column(
        children: [
          DetailsScreenTextField(
            isReadOnly: state.isReadOnly,
            state: state.descriptionFieldState,
            maxLines: 27,
            fontSize: 16,
            showBorder: false,
          ),
          if (urlExists && state.isReadOnly) DetailsScreenLinkTab(note: state.note),
        ],
      ),
    );
  }
}
