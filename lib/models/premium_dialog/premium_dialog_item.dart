import 'package:flutter/cupertino.dart';

class PremiumDialogItem {
  final String title;
  final String description;
  final String button;

  const PremiumDialogItem._({
    required this.title,
    required this.description,
    required this.button,
  });

  static const on = PremiumDialogItem._(
    title: 'Are you sure you want to turn off the Premium version?',
    description: 'If you turn off the Premium version, you will lose a lot of useful features!',
    button: 'TURN IT OFF',
  );
  static const off = PremiumDialogItem._(
    title: 'Buy Premium version by only one click!',
    description: 'Get the Premium version to unlock a lot of useful features!',
    button: 'GET IT NOW',
  );
  static const details = PremiumDialogItem._(
    title: 'To edit your notes you must buy a premium version!',
    button: 'GET IT NOW',
    description: '',
  );
  static const time = PremiumDialogItem._(
    title: 'Buy Premium version and have unlimited time!',
    description: 'Get the Premium version to unlock an unlimited time for writing your notes!',
    button: 'GET IT NOW',
  );
}
