import 'dart:io';

import 'package:app/common/widget/app_nav_bar_item.dart';
import 'package:app/service/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AppNavBar extends StatelessWidget {
  final state;
  final Function() exitFunction;

  const AppNavBar({
    required this.state,
    required this.exitFunction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
// Left Side
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNavBarItem(
                  onPressed: () async {
                    final result = await showExitDialog(context);
                    if (result) {
                      exitFunction();
                    }
                  },
                  icon: AppIcons.exit,
                  name: ' exit ',
                ),
                AppNavBarItem(
                  onPressed: () async {
                    final pickedImage = await ImagePicker.platform.pickImage(
                      source: ImageSource.gallery,
                        maxWidth: 1920,
                        maxHeight: 1200,
                        imageQuality: 80,
                    );

                    if (pickedImage != null) {
                      File imagePath = File(pickedImage.path);
                      String imageName = imagePath.path.split('/').last;
                      print(imagePath.path);
                      print(imageName);
                    }
                  },
                  icon: AppIcons.addImage,
                  name: ' image ',
                ),
              ],
            ),
// Right Side
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNavBarItem(
                  onPressed: () {},
                  icon: AppIcons.addLink,
                  name: ' link ',
                ),
                AppNavBarItem(
                  onPressed: () {
                    state.onSaveBtn();
                    Navigator.pop(context, true);
                  },
                  icon: AppIcons.save,
                  name: ' save ',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showExitDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text(
        'Are you sure you want to exit?',
        style: TextStyle(fontSize: 16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "If you press 'ok' your notes are not going to be saved.",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(
              AppIcons.yes,
              color: Colors.brown,
              size: 40,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: const Icon(
              AppIcons.no,
              color: Colors.brown,
              size: 40,
            ),
          ),
        ),
      ],
    ),
  );
}
