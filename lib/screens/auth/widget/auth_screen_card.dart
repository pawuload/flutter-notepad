import 'package:app/screens/auth/state/auth_screen_state.dart';
import 'package:app/screens/auth/widget/auth_screen_form.dart';
import 'package:flutter/material.dart';

class AuthScreenCard extends StatelessWidget {
  final AuthScreenState state;

  const AuthScreenCard({
    Key? key,
    required this.state,
  }) : super(key: key);

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
                AuthScreenForm(state: state),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CheckboxListTile(
                    value: state.isCheckboxOn,
                    onChanged: (_) => state.onCheckboxPressed(),
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
