import 'package:app/models/note/note.dart';
import 'package:app/screens/home/state/home_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreenListItem extends StatelessWidget {
  final Note note;
  final HomeScreenState state;

  const HomeScreenListItem({Key? key, required this.note, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
      state.isButtonOpen ? state.onHomePressed() : state.onItemPressed(note)
    },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  note.details.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      DateFormat.yMMMd().format(note.details.created),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      note.details.description.length > 36 ? note.details.description.substring(0, 36) + '...' : note.details.description,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
