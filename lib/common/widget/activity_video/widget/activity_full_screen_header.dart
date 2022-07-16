import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';
import 'package:wakelock/wakelock.dart';

class ActivityFullscreenHeader extends HookWidget {
  const ActivityFullscreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildBoxDecoration(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () async {
                  context.navigator.pop();
                  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                  await Wakelock.toggle(enable: false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.72),
          Colors.transparent,
        ],
      ),
    );
  }
}
