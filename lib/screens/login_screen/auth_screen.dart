import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/common/constants/app_images.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_textfield.dart';

String userEmail = '';
String userPassword = '';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  Future _submitAuthForm() async {
    String _message = '';
    bool _error = false;
    UserCredential _userCredential;
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail.trim(),
        password: userPassword,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _userCredential = await _auth.createUserWithEmailAndPassword(
          email: userEmail.trim(),
          password: userPassword,
        );
      } else if (e.code == 'wrong-password') {
        _message = 'The password is invalid.';
        _error = true;
      } else if (e.code == 'network-request-failed') {
        _message = 'A network error has occurred';
        _error = true;
      } else {
        _message = 'Error: logging in failed. Please, try again later';
        _error = true;
      }
      if (_error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(
              _message,
              style: const TextStyle(color: Colors.red),
            ),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }

  bool value = false;
  bool isChecked = true;
  bool isButtonActive = true;

  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  void submit() {
    final isEmailValid = emailKey.currentState!.validate();
    final isPasswordValid = passwordKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    final isValid = isEmailValid && isPasswordValid;
    if (isValid) {
      emailKey.currentState!.save();
      passwordKey.currentState!.save();
    }

    if (isButtonActive && isValid) {
      _submitAuthForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              height: 165,
              child: Hero(
                tag: 'logo',
                child: Image.asset(AppImages.logo),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _buildForm(
                          value,
                          emailKey,
                          passwordKey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CheckboxListTile(
                            value: value,
                            onChanged: (value) {
                              setState(() {
                                this.value = value!;
                                isChecked = value;
                                isButtonActive = value;
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
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppButton(
              title: 'Login',
              onPressed: submit,
            ),
          ),
        ],
      ),
    );
  }
}

Column _buildForm(
  value,
  emailKey,
  passwordKey,
) {
  return Column(
    children: [
      Form(
        key: emailKey,
        child: Field(
          hintText: 'Email',
          icon: const Icon(Icons.account_circle),
          enabled: value,
          inputType: TextInputType.emailAddress,
          obscure: false,
          onSaved: (val) {
            userEmail = val;
          },
          validator: (input) {
            if (input == null || !input.contains('@') || !input.contains('.')) {
              return 'Please enter a valid email address.';
            }
            return null;
          },
        ),
      ),
      Form(
        key: passwordKey,
        child: Field(
          hintText: 'Password',
          icon: const Icon(Icons.lock),
          enabled: value,
          inputType: TextInputType.visiblePassword,
          obscure: true,
          onSaved: (val) {
            userPassword = val;
          },
          validator: (input) {
            if (input == null || input.length < 7) {
              return 'Password must be at least 7 characters long';
            }
            return null;
          },
        ),
      ),
    ],
  );
}