import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/screens/add_screen/state/add_screen_state.dart';

class AddScreenTitle extends StatelessWidget {
  final AddScreenState state;

  const AddScreenTitle({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.4,
            color: Colors.brown,
          ),
        ),
      ),
      child: SizedBox(
        height: 60,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              decoration: const InputDecoration.collapsed(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
