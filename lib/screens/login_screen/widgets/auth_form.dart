import 'package:flutter/material.dart';
import '../../../common/widgets/app_textfield.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool value = false;
  bool isChecked = true;

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
                _buildFields(value),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CheckboxListTile(
                    value: value,
                    onChanged: (value) {
                      setState(() {
                        this.value = value!;
                        isChecked = value;
                      });
                    },
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

Column _buildFields(bool value) {
  return Column(
    children: [
      Field(
        hintText: 'Email',
        icon: const Icon(Icons.account_circle),
        enabled: value,
        inputType: TextInputType.emailAddress,
        obscure: false,
      ),
      Field(
        hintText: 'Password',
        icon: const Icon(Icons.lock),
        enabled: value,
        inputType: TextInputType.visiblePassword,
        obscure: true,
      ),
    ],
  );
}
