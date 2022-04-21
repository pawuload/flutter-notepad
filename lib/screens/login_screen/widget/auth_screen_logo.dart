import 'package:flutter/material.dart';
import '../../../common/constans/app_images.dart';

class AuthScreenLogo extends StatelessWidget {
  const AuthScreenLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        height: 165,
        child: Hero(
          tag: 'logo',
          child: Image.asset(AppImages.logo),
        ),
      ),
    );
  }
}
