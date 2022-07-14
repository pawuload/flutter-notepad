import 'package:app/common/constans/app_color.dart';
import 'package:app/screens/details/state/details_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app/common/constans/app_icons.dart';

class DetailsScreenButton extends StatelessWidget {
  final DetailsScreenState state;

  const DetailsScreenButton({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeBackgroundColor: Colors.brown[300],
      buttonSize: const Size(53, 53),
      childrenButtonSize: const Size(53, 53),
      animatedIcon: state.isLoading ? null : AnimatedIcons.menu_close,
      child: state.isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            )
          : null,
      elevation: 10,
      spacing: 3,
      spaceBetweenChildren: 5,
      overlayColor: Colors.brown[200],
      overlayOpacity: 0.4,
      children: [
        _buildDeleteButton(),
        _buildDeleteButton(),
        _buildEditButton(),
      ],
    );
  }

  SpeedDialChild _buildDeleteButton() {
    return SpeedDialChild(
      backgroundColor: Colors.brown[300],
      child: const Icon(
        AppIcons.delete,
        color: Colors.white,
      ),
      onTap: state.onDeletePressed,
    );
  }

  SpeedDialChild _buildPremiumButton() {
    return SpeedDialChild(
      backgroundColor: Colors.brown[300],
      child: const Icon(
        AppIcons.backHome,
        color: Colors.white,
      ),
      onTap: state.onExitPressed,
    );
  }

  SpeedDialChild _buildEditButton() {
    return SpeedDialChild(
      backgroundColor: state.isPremium ? Colors.brown[300] : AppColors.premium,
      child: Icon(
        state.isReadOnly ? AppIcons.edit : AppIcons.read,
        color: Colors.white,
      ),
      onTap: state.onEditPressed,
    );
  }
}
