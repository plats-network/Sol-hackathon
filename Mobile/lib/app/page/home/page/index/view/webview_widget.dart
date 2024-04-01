import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String url;

  const WebViewWidget({super.key, required this.url});
  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final _key = UniqueKey();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // appBar: AppBar(),
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.url,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ),
            isLoading
                ? const Center(
                    child:  FullScreenProgress(),
                  )
                : Stack(),
            Positioned(
              top: Platform.isIOS && MediaQuery.of(context).size.height >= 700
                  ? dimen50
                  : dimen20,
              right: dimen16,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  getAssetImage(AssetImagePath.clear),
                  width: dimen30,
                  height: dimen30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
