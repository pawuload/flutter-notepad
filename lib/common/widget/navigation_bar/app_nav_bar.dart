import 'dart:io';

import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:image_picker/image_picker.dart';

import 'app_nav_bar_item.dart';

class AppNavBar extends StatelessWidget {
  final Function() onSavePressed;
  final Function() onExitPressed;

  const AppNavBar({
    required this.onSavePressed,
    required this.onExitPressed,
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
                    final result = await AppAlertDialog.showExit(context);
                    if (result == true) {
                      onExitPressed();
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
                    onSavePressed();
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


