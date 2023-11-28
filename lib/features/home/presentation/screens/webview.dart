// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:zest_trip/config/routes/routes.dart';
import 'package:zest_trip/config/utils/resources/confirm_dialog.dart';

class MyWebView extends StatefulWidget {
  final String urlWeb;
  final String title;
  const MyWebView({
    Key? key,
    required this.urlWeb,
    required this.title,
  }) : super(key: key);

  @override
  MyWebViewState createState() => MyWebViewState();
}

class MyWebViewState extends State<MyWebView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
                Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://google.com')) {
              debugPrint('blocking navigation to ${request.url}');
              Navigator.pushNamed(context, AppRoutes.thanksBooking);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.urlWeb));
    return WillPopScope(
      onWillPop: () async {
        bool? confirmExit = await DialogUtils.showConfirmDialog(
          context,
          title: 'Confirm Exit',
          content: 'Do you really want to exit?',
          noText: 'No',
          yesText: 'Yes',
        );
        return confirmExit ?? false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                bool? confirmExit = await DialogUtils.showConfirmDialog(
                  context,
                  title: 'Confirm exit',
                  content: 'Your booking will be cancelled!',
                  noText: 'Cancel',
                  yesText: 'Confirm',
                );
                if (confirmExit != null && confirmExit) {
                  Navigator.of(context).pop();
                }
              },
            ),
            automaticallyImplyLeading: false,
            title: Text(widget.title),
            actions: const [],
          ),
          body: WebViewWidget(controller: controller)),
    );
  }
}
