import 'package:app/common/widget/bottom_sheet/app_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailsScreenBottomSheet extends StatelessWidget {
  final String url;

  static Future<void> show(BuildContext context, String url) async {
    return await AppBottomSheet.show(context, (context) => DetailsScreenBottomSheet(url: url));
  }

  const DetailsScreenBottomSheet({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UniqueKey _key = UniqueKey();
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      minimum: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
      child: AppBottomSheet(
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, top: 32),
          child: WebView(
            key: _key,
            initialUrl: url,
            gestureNavigationEnabled: true,
            gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
          ),
        ),
      ),
    );
  }
}