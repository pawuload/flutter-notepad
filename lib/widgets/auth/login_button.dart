import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      elevation: 25,
      child: SizedBox(
        width: 310,
        height: 50,
        child: ElevatedButton(
          child: const Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          ),
          onPressed: () {},
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side: const BorderSide(color: Colors.brown),
                  ))),
        ),
      ),
    );
  }
}
