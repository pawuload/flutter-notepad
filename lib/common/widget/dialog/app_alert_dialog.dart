import 'package:app/common/constans/app_color.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:app/models/premium_dialog/premium_dialog_item.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  static Future<T?> show<T extends Object>(BuildContext context, Widget Function(BuildContext) builder) async {
    final route = DialogRoute<T>(context: context, builder: builder);
    return await Navigator.of(context).push(route);
  }

  static Future<T?> showCustom<T extends Object>(BuildContext context, {required Widget title, required Widget content}) async {
    return await show<T>(
      context,
      (context) {
        return AppAlertDialog(title: title, content: content);
      },
    );
  }

  static Future<bool?> showExit(BuildContext context) async {
    return await show<bool>(
      context,
      (context) {
        return AppAlertDialog(
          title: const Text(
            'Are you sure you want to exit?',
            style: TextStyle(fontSize: 16),
          ),
          content: const Text(
            "If you press 'ok' your notes are not going to be saved.",
            style: TextStyle(fontSize: 14),
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
        );
      },
    );
  }

  static Future<bool?> showDelete(BuildContext context) async {
    return await show<bool>(
      context,
      (context) => AlertDialog(
        title: const Text(
          'Are you sure you want to delete this note?',
          style: TextStyle(fontSize: 16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "If you delete it, it will be gone forever...",
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

  static Future<bool?> showSave(BuildContext context) async {
    return await show<bool>(
      context,
      (context) {
        return AppAlertDialog(
          title: const Text(
            'Uploading...',
            style: TextStyle(fontSize: 16),
          ),
          content: const Text(
            "Video or image is still uploading.\n"
                "If you press 'ok' it's not going to be saved.\n"
                "Remember to name your note.",
            style: TextStyle(fontSize: 14),
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
        );
      },
    );
  }

  static Future<bool?> showPremium(BuildContext context, {required PremiumDialogItem item}) async {
    return await show<bool>(
      context,
      (context) {
        return AppAlertDialog(
          title: Text(
            item.title,
            style: const TextStyle(fontSize: 20),
          ),
          content: Text(
            item.description,
            style: const TextStyle(fontSize: 15),
          ),
          actions: <Widget>[
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppColors.premium, elevation: 10),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    item.button,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  final Widget title;
  final Widget? content;
  final List<Widget>? actions;

  const AppAlertDialog({Key? key, required this.title, required this.content, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      title: title,
      content: content,
      actions: actions,
    );
  }
}
