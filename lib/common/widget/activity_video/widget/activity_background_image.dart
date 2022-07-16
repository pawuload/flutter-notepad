import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:utopia_utils/utopia_utils.dart';


class ActivityBackgroundImage extends StatelessWidget {
  final Widget child;
  final String imageUrl;

  const ActivityBackgroundImage({
    Key? key,
    required this.child,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.network(
                imageUrl,
                key: ValueKey(imageUrl),
                cacheWidth: MediaQuery.of(context).let((it) => it.size.width * it.devicePixelRatio).toInt(),
                fit: BoxFit.cover,
                height: height,
                width: width,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.42),
          ),
        ),
        child,
      ],
    );
  }
}
