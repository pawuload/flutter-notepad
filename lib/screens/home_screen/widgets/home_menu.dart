import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app/common/constants/app_icons.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      activeBackgroundColor: Colors.brown[300],
      buttonSize: const Size(50, 50),
      childrenButtonSize: const Size(50, 50),
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
            AppIcons.logout,
            color: Colors.white,
          ),
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        ),
        SpeedDialChild(
          backgroundColor: Colors.brown[300],
          child: const Icon(
            AppIcons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}