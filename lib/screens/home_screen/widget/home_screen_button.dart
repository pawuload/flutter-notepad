import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:app/screens/add_screen/add_screen.dart';
import 'package:app/screens/home_screen/state/home_screen_state.dart';
import 'package:app/screens/login_screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:app/common/constans/app_color.dart';

class HomeScreenButton extends StatelessWidget {
  final HomeScreenState state;

  const HomeScreenButton({
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
            AppIcons.add,
            color: Colors.white,
          ),
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddScreen()),
            );
            if (result == true) state.noteState.refresh();
          },
        ),
        SpeedDialChild(
          backgroundColor: Colors.brown[300],
          child: const Icon(
            AppIcons.logout,
            color: Colors.white,
          ),
          onTap: () async {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthScreen(),
              ),
            );
          },
        ),
        SpeedDialChild(
          backgroundColor: state.userState.user!.details.isPremium ? Colors.brown[300] : AppColors.premium,
          child: const Icon(
            AppIcons.premium,
            color: Colors.white,
          ),
          onTap: () async {
            if (state.userState.user!.details.isPremium == false) {
              final result = await AppAlertDialog.showPremium(
                context,
                title: 'Buy Premium version by only one click!',
                description: 'Get the Premium version to unlock a lot of useful features!',
                button: 'GET IT NOW',
              );
              if (result == true) {
                state.switchPremium();
                state.userState.refresh();
              }
            } else {
              final result = await AppAlertDialog.showPremium(
                context,
                title: 'Are you sure you want to turn off the Premium version?',
                description: 'If you turn off the Premium version, you will lose a lot of useful features!',
                button: 'TURN IT OFF',
              );
              if (result == true) {
                state.switchPremium();
                state.userState.refresh();
              }
            }
          },
        ),
      ],
    );
  }
}
