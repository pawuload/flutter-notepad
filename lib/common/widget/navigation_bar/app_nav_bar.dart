import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:app/common/constans/app_icons.dart';
import 'app_nav_bar_item.dart';

class AppNavBar extends StatelessWidget {
  final Function() onSavePressed;
  final Function() onExitPressed;
  final Function() onImagePressed;
  final Function() onLinkPressed;

  const AppNavBar({
    required this.onSavePressed,
    required this.onExitPressed,
    required this.onImagePressed,
    required this.onLinkPressed,
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
                  onPressed: () => onImagePressed(),
                  icon: AppIcons.addImage,
                  name: ' image ',
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNavBarItem(
                  onPressed: () => onLinkPressed(),
                  icon: AppIcons.addLink,
                  name: ' link ',
                ),
                AppNavBarItem(
                  onPressed: () {
                    onSavePressed();
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
