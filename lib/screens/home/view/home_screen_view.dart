import 'package:app/screens/home/state/home_screen_state.dart';
import 'package:app/screens/home/widget/home_screen_button.dart';
import 'package:app/screens/home/widget/home_screen_notes_list.dart';
import 'package:flutter/material.dart';
import 'package:app/common/constans/app_images.dart';

class HomeScreenView extends StatelessWidget {
  final HomeScreenState state;

  const HomeScreenView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: HomeScreenButton(state: state),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildLogo(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.only(bottom: 0),
              child: RawScrollbar(
                thumbColor: Colors.brown.withOpacity(0.6),
                radius: const Radius.circular(20),
                thickness: 5,
                child: HomeScreenNotesList(
                  state: state,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
      height: 100,
      child: Hero(
        tag: 'logo',
        child: Image.asset(AppImages.logo),
      ),
    );
  }
}
