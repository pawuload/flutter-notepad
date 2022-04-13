import 'package:flutter/material.dart';

class Fields extends StatelessWidget {
  const Fields({Key? key}) : super(key: key);

  get prefixIcon => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 310,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              prefixIcon: prefixIcon??const Icon(Icons.account_circle),
              hintText: 'E-mail',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 310,
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              prefixIcon: prefixIcon??const Icon(Icons.lock),
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
