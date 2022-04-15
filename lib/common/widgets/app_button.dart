import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final String textBtn;

  const Btn({Key? key, required this.textBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 45,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        elevation: 25,
        child: ElevatedButton(
          child: Text(
            textBtn,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          ),
          onPressed: () {},
          style: _buildButtonStyle(),
        ),
      ),
    );
  }
}

ButtonStyle _buildButtonStyle() {
  return ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: const BorderSide(color: Colors.brown),
      ),
    ),
  );
}