import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app/common/constans/app_icons.dart';

class AddScreenButton extends StatelessWidget {
  const AddScreenButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpeedDial(
      icon: AppIcons.premium,
      elevation: 10,
    );
  }
}
