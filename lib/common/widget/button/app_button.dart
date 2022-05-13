import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final bool enabled;
  final bool loading;

  const AppButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.enabled = true,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 45,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        elevation: 25,
        child: Opacity(
          opacity: enabled ? 1 : 0.6,
          child: ElevatedButton(
            child: loading
                ? const SpinKitThreeBounce(
                    color: Colors.white,
                    size: 17,
                  )
                : Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
            onPressed: () {
              if (enabled) onPressed();
            },
            style: _buildButtonStyle(),
          ),
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
