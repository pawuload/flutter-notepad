import 'package:app/models/note/note.dart';
import 'package:app/screens/home_screen/state/home_screen_state.dart';
import 'package:app/screens/home_screen/widget/home_screen_list_item.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/home_screen/widget/home_screen_button.dart';
import 'package:app/common/constans/app_images.dart';
import 'package:intl/intl.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useHomeScreenState();

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
                inProgressBuilder: (context) => Container(),
                failedBuilder: (context) => Container(),
                emptyBuilder: (context) => Container(),
                builder: (context, notes) {
                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return HomeScreenListItem(
                        title: notes[index].title,
                        date: DateFormat.yMMMd().format(notes[index].created),
                        description: notes[index].description,
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
