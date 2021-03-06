import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppVideoPlayerLoading extends StatelessWidget {
  final Color backgroundColor;
  final Color bounceColor;

  const AppVideoPlayerLoading({
    required this.backgroundColor,
    required this.bounceColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: SpinKitThreeBounce(
          color: bounceColor,
          size: 20,
        ),
      ),
    );
  }
}
