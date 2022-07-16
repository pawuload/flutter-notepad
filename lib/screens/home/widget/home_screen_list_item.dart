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
      onTap: () => state.onItemPressed(note),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            Row(
              children: [
                _buildDate(),
                _buildDescription(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        note.details.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget _buildDate() {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Text(
        DateFormat.yMMMd().format(note.details.created),
        style: const TextStyle(fontSize: 11),
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Text(
        note.details.description.length > 36 ? note.details.description.substring(0, 35) + '...' : note.details.description,
        maxLines: 1,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 5,
          offset: const Offset(3, 3),
        ),
      ],
    );
  }
}
