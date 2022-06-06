import 'package:app/models/note/note.dart';
import 'package:app/screens/details/state/details_screen_state.dart';

import 'package:flutter/material.dart';

class ImagesCard extends StatelessWidget {
  final DetailsScreenState state;
  final Note note;

  const ImagesCard({Key? key, required this.state, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: Container(
        width: 350,
        height: 150,
        child: Card(
          elevation: 25,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (note.details.imageUrl != null)
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.network(note.details.imageUrl!),
                  ),
                Container(
                  width: 100,
                  height: 100,
                  child: Image.network(note.details.imageUrl!),
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: Image.network(note.details.imageUrl!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
