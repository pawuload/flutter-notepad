import 'package:app/common/constans/app_color.dart';
import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:app/screens/details_screen/state/details_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app/common/constans/app_icons.dart';

class DetailsScreenButton extends StatelessWidget {
  final DetailsScreenState state;

  const DetailsScreenButton({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeBackgroundColor: Colors.brown[300],
      buttonSize: const Size(55, 55),
      childrenButtonSize: const Size(55, 55),
      animatedIcon: AnimatedIcons.menu_close,
      elevation: 10,
      spacing: 3,
      spaceBetweenChildren: 5,
      overlayColor: Colors.brown[200],
      overlayOpacity: 0.4,
      children: [
        SpeedDialChild(
          backgroundColor: Colors.brown[300],
          child: const Icon(
            AppIcons.delete,
            color: Colors.white,
          ),
          onTap: () async {
            final result = await showDeleteDialog(context);
            if (result) {
              state.onDeleteBtn();
              Navigator.pop(context, true);
            }
          },
        ),
        SpeedDialChild(
          backgroundColor: Colors.brown[300],
          child: const Icon(
            AppIcons.backHome,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        SpeedDialChild(
          backgroundColor: state.isPremium ? Colors.brown[300] : AppColors.premium,
          child: Icon(
            state.isReadOnlyState ? AppIcons.edit : AppIcons.read,
            color: Colors.white,
          ),
          onTap: () async {
            if (state.isPremium == false) {
              final result = await AppAlertDialog.showPremium(context,
                  title: 'To edit your notes you must buy a premium version!', button: 'GET IT NOW', description: '');
              if (result == true) {
                state.switchPremium();
                state.switchReadOnly();
                state.userState.refresh();
              }
            } else {
              state.switchReadOnly();
            }
          },
        ),
      ],
    );
  }
}

Future<bool> showDeleteDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
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
