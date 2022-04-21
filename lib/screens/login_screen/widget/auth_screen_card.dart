import 'package:flutter/material.dart';
import 'auth_screen_form.dart';

class AuthScreenCard extends StatefulWidget {
  const AuthScreenCard({
    Key? key,
    required this.value,
    required this.passwordKey,
    required this.emailKey,
    required this.setUserEmail,
    required this.setUserPassword,
    required this.onChanged,
  }) : super(key: key);
  final value;
  final emailKey;
  final passwordKey;
  final Function setUserEmail;
  final Function setUserPassword;
  final Function onChanged;

  @override
  State<AuthScreenCard> createState() => _AuthScreenCardState();
}

class _AuthScreenCardState extends State<AuthScreenCard> {
  get onChange => widget.onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          elevation: 25,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AuthScreenForm(
                  passwordKey: widget.passwordKey,
                  emailKey: widget.emailKey,
                  value: widget.value,
                  onSavedEmail: widget.setUserEmail,
                  onSavedPassword: widget.setUserPassword,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CheckboxListTile(
                    value: widget.value,
                    onChanged: onChange,
                    title: const Text(
                      'I consent to the processing of data for the marketing purposes',
                      style: TextStyle(fontSize: 15),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
