import 'package:flutter/material.dart';
import '../auth/text_field.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
             Fields(),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                width: 310,
                height: 40,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
