import 'package:app/common/widget/navigation_bar/app_nav_bar.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:app/screens/details/widget/details_screen_attachments.dart';
import 'package:app/screens/details/widget/details_screen_button.dart';
import 'package:app/screens/details/widget/details_screen_textfield.dart';
import 'package:app/screens/details/widget/details_screen_url.dart';
import 'package:flutter/material.dart';

class DetailsScreenView extends StatelessWidget {
  final DetailsScreenState state;

  const DetailsScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => state.onWillPop(),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              _buildDetailsScreenTextFieldTitle(),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildDetailsScreenTextFieldDescription(),
                ),
              ),
              DetailsScreenAttachments(state: state, note: state.note),
              if (state.isLinkTabOpen == true)
                if (state.isReadOnly == false) DetailsScreenUrl(state: state),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: DetailsScreenButton(state: state),
        ),
        floatingActionButtonLocation: state.isReadOnly ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: state.isReadOnly
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

  Widget _buildDetailsScreenTextFieldDescription() {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: DetailsScreenTextField(
        isReadOnly: state.isReadOnly,
        state: state.descriptionFieldState,
        maxLines: 32,
        fontSize: 16,
        showBorder: false,
      ),
    );
  }
}
