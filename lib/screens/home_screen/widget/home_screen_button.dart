import 'package:app/screens/add_screen/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app/common/constans/app_icons.dart';
import 'package:app/common/constans/app_color.dart';

class HomeScreenButton extends StatelessWidget {
  const HomeScreenButton({Key? key}) : super(key: key);

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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddScreen()),
            );
          },
        ),
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
          backgroundColor: AppColors.premium,
          child: const Icon(
            AppIcons.premium,
            color: Colors.white,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
