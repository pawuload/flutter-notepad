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
              final result = await showPremiumDialog(
                context,
                'Buy Premium version by only one click!',
                'Get the Premium version to unlock a lot of useful features!',
                'GET IT NOW',
              );
              if (result) {
                state.switchPremium();
                state.userState.refresh();
              }
            } else {
              final result = await showPremiumDialog(
                context,
                'Are you sure you want to turn off the Premium version?',
                'If you turn off the Premium version, you will lose a lot of useful features!',
                'TURN IT OFF',
              );
              if (result) {
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

Future<bool> showPremiumDialog(BuildContext context, String text, String descriptionText, String buttonText) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            descriptionText,
            style: const TextStyle(fontSize: 15),
          ),
        ],
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
                buttonText,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
