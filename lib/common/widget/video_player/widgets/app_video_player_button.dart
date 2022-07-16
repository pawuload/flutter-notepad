import 'package:flutter/material.dart';

class AppVideoPlayerButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final double iconSize;

  const AppVideoPlayerButton({
    required this.icon,
    required this.onTap,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.yellow,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}
