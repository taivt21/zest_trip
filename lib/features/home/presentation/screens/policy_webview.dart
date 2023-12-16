// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:zest_trip/config/routes/routes.dart';

class PolicyWebView extends StatefulWidget {
  final String urlWeb;
  final String title;
  const PolicyWebView({
    Key? key,
    required this.urlWeb,
    required this.title,
  }) : super(key: key);

  @override
  PolicyWebViewState createState() => PolicyWebViewState();
}

class PolicyWebViewState extends State<PolicyWebView> {
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
            // debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            // debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            //   debugPrint('''
            //       Page resource error:
            //       code: ${error.errorCode}
            //       description: ${error.description}
            //       errorType: ${error.errorType}
            //       isForMainFrame: ${error.isForMainFrame}
            // ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://google.com')) {
              // debugPrint('blocking navigation to ${request.url}');
              Fluttertoast.showToast(
                msg: "Booking success!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.thanksBooking, (route) => false);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.urlWeb));
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.title),
          actions: const [],
        ),
        body: WebViewWidget(controller: controller));
  }
}
