import 'package:flutter/material.dart';

class AddScreenUrl extends StatelessWidget {
  const AddScreenUrl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   DecoratedBox(
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
        child: const SingleChildScrollView(
          child: Text(
            'www.goggle.pl',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
