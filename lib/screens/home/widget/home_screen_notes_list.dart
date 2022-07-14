import 'package:app/models/note/note.dart';
import 'package:app/screens/home/state/home_screen_state.dart';
import 'package:app/screens/home/widget/home_screen_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class HomeScreenNotesList extends StatelessWidget {
  final HomeScreenState state;

  const HomeScreenNotesList({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshableComputedListWrapper<Note>(
      state: state.noteState,
      inProgressBuilder: (context) => _buildInProgressBuilder(),
      failedBuilder: (context) => _buildFailedBuilder(),
      emptyBuilder: (context) => _buildEmptyBuilder(),
      builder: (context, notes) => _buildListViewBuilder(notes),
    );
  }

  Widget _buildListViewBuilder(List notes) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: HomeScreenListItem(
                note: notes[index],
                state: state,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInProgressBuilder() {
    return Center(
      child: Text(
        'Loading...',
        style: TextStyle(
          fontSize: 18,
          color: Colors.brown.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildEmptyBuilder() {
    return Column(
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
    );
  }

  Widget _buildFailedBuilder() {
    return Center(
      child: Text(
        'Loading notes has been failed. Please try again later.',
        style: TextStyle(
          fontSize: 15,
          color: Colors.brown.withOpacity(0.5),
        ),
      ),
    );
  }
}
