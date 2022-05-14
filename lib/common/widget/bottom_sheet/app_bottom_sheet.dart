import 'package:flutter/material.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final bool resizeToAvoidBottomInset;

  const AppBottomSheet({Key? key, required this.child, this.resizeToAvoidBottomInset = false}) : super(key: key);

  static Future<T?> show<T>(BuildContext context, Widget Function(BuildContext context) builder) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (resizeToAvoidBottomInset) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: MediaQuery.removeViewInsets(context: context, child: _buildContent()),
      );
    }
    return _buildContent();
  }

  Widget _buildContent() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: child,
    );
  }
}
