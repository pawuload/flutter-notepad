import 'package:app/common/widget/activity_video/widget/activity_background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ActivityFullScreenLayout extends HookWidget {
  final double aspectRatio;
  final String backgroundImage;
  final Function(BuildContext, BoxConstraints) portraitBuilder;
  final Function(BuildContext, BoxConstraints) landscapeBuilder;

  const ActivityFullScreenLayout({
    Key? key,
    required this.backgroundImage,
    required this.landscapeBuilder,
    required this.portraitBuilder,
    required this.aspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          body: ActivityBackgroundImage(
            imageUrl: backgroundImage,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return aspectRatio < 1.5 ? portraitBuilder(context, constraints) : landscapeBuilder(context, constraints);
                // return portraitBuilder(context,constraints);
              },
            ),
          ),
        );
      },
    );
  }
}
