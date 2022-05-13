import 'package:app/models/note/note.dart';
import 'package:app/screens/details_screen/widget/details_screen_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class AddScreenUrl extends StatelessWidget {
  const AddScreenUrl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(
          width: 0.4,
          color: Colors.brown,
        ),
      )),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        height: 85,
        child: SingleChildScrollView(

        ),
      ),
    );
  }
}