import 'package:app/common/constans/app_color.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:app/screens/home/state/home_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreenButton extends StatelessWidget {
  final HomeScreenState state;

  const HomeScreenButton({Key? key, required this.state}) : super(key: key);

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
        _buildAddButton(),
        _buildLogoutButton(),
        _buildPremiumButton(),
      ],
    );
  }

  SpeedDialChild _buildAddButton() {
    return SpeedDialChild(
      backgroundColor: Colors.brown[300],
      child: const Icon(
        AppIcons.add,
        color: Colors.white,
      ),
      onTap: state.onAddButtonPressed,
    );
  }

  SpeedDialChild _buildLogoutButton() {
    return SpeedDialChild(
      backgroundColor: Colors.brown[300],
      child: const Icon(
        AppIcons.logout,
        color: Colors.white,
      ),
      onTap: state.onSignOutPressed,
    );
  }

  SpeedDialChild _buildPremiumButton() {
    return SpeedDialChild(
      backgroundColor: state.userState.user!.details.isPremium ? Colors.brown[300] : AppColors.premium,
      child: const Icon(
        AppIcons.premium,
        color: Colors.white,
      ),
      onTap: state.onPremiumPressed,
    );
  }
}
