import 'package:app/models/note/note.dart';
import 'package:app/screens/home/state/home_screen_state.dart';
import 'package:app/screens/home/widget/home_screen_button.dart';
import 'package:app/screens/home/widget/home_screen_list_item.dart';
import 'package:flutter/material.dart';
import 'package:app/common/constans/app_images.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

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
          Container(
            margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            height: 100,
            child: Hero(
              tag: 'logo',
              child: Image.asset(AppImages.logo),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.only(bottom: 0),
              child: RefreshableComputedListWrapper<Note>(
                state: state.noteState,
                inProgressBuilder: (context) => Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.brown.withOpacity(0.5),
                    ),
                  ),
                ),
                failedBuilder: (context) => Center(
                  child: Text(
                    'Loading notes has been failed. Please try again',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.brown.withOpacity(0.5),
                    ),
                  ),
                ),
                emptyBuilder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      child: Text(
                        'Create a new note right there',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.brown.withOpacity(0.5),
                        ),
                      ),
                    )
                  ],
                ),
                builder: (context, notes) {
                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return HomeScreenListItem(
                        note: notes[index],
                        state: state,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
