import 'package:app/common/constans/app_color.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:app/screens/add/state/add_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AddScreenButton extends StatelessWidget {
  final AddScreenState state;

  const AddScreenButton({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      child: Container(
        child: state.isPremium ? const Icon(AppIcons.premium) : Text(state.timeLeft.toString()),
      ),
      backgroundColor: state.isPremium ? Colors.brown : AppColors.premium,
      elevation: 10,
    );
  }
}
