import 'package:flutter/material.dart';

class AddScreenNavBarItem extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final String name;

  const AddScreenNavBarItem({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 50,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.brown,
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.brown),
          ),
        ],
      ),
    );
  }
}
