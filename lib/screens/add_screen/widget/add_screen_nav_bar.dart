import 'package:app/screens/add_screen/widget/add_screen_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:app/screens/add_screen/state/add_screen_state.dart';

class AddScreenNavBar extends StatelessWidget {
  final AddScreenState state;

  const AddScreenNavBar({
    required this.state,
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
                AddScreenNavBarItem(
                  onPressed: () async {
                    final result = await showExitDialog(context);
                    if (result) {
                      Navigator.pop(context);
                    }
                  },
                  icon: AppIcons.exit,
                  name: ' exit ',
                ),
                AddScreenNavBarItem(
                  onPressed: () {},
                  icon: AppIcons.addImage,
                  name: ' image ',
                ),
              ],
            ),
// Right Side
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddScreenNavBarItem(
                  onPressed: () {},
                  icon: AppIcons.addLink,
                  name: ' link ',
                ),
                AddScreenNavBarItem(
                  onPressed: () {
                    state.onSaveBtn();
                    Navigator.pop(context);
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
