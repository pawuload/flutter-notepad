import 'package:flutter/material.dart';

class Fields extends StatefulWidget {
  const Fields({Key? key}) : super(key: key);

  @override
  State<Fields> createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  get prefixIcon => null;
  bool value = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 310,
          child: TextFormField(
            enabled: isChecked,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              prefixIcon: prefixIcon ?? const Icon(Icons.account_circle),
              hintText: 'E-mail',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
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
          height: 10,
        ),
        SizedBox(
          width: 310,
          child: TextFormField(
            enabled: isChecked,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              prefixIcon: prefixIcon ?? const Icon(Icons.lock),
              hintText: 'Password',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: 310,
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
        ),
      ],
    );
  }
}
