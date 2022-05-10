import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

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
          child: Link(
            target: LinkTarget.self,
            uri: Uri.parse('https://www.youtube.com'),
            builder: (context, followLink) => GestureDetector(
              onTap: followLink,
              child: const Text(
                'www.goggle.pl',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
