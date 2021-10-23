import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:truthinx/utils/ApiKeys.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripePaymentCheckout extends StatefulWidget {
  final String sessionId;
  
  StripePaymentCheckout({this.sessionId});
  @override
  _StripePaymentCheckoutState createState() => _StripePaymentCheckoutState();
}

class _StripePaymentCheckoutState extends State<StripePaymentCheckout> {
  WebViewController _webViewController;

  String get initialUrl =>
      "data:text/html;base64,${base64Encode(Utf8Encoder().convert(kStripeHTMLPage))}";

  static const String kStripeHTMLPage = '''
  <!DOCTYPE html>
  <html>
  <script src="https://js.stripe.com/v3/"></script>

  <head>
      <title>Stripe Checkout</title>
  </head>

  <body>
      <div style="position: absolute; text-align: center; width:100%; height:100%; top:50%;">
          <p>Loding payment gateway...!</p>
      </div>
  </body>

  </html>
  ''';

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: WebView(
          initialUrl: initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) =>
              _webViewController = webViewController,
          onPageFinished: (String url) {
            if (url == initialUrl) {
              _redirectToStripe(widget.sessionId);
            }
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://success.com')) {
               print("success");
               Navigator.of(context).pop("success");
              // Navigator.of(context).pop("success");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => DetailsScreen(widget.doc),
              //   ),
              // );
            } else if (request.url.startsWith('https://cancel.com')) {
              print("Canceled");
              Navigator.of(context).pop('cancel');
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }

  Future<void> _redirectToStripe(String sessionId) async {
    final redirectToCheckoutJs = '''
    var stripe = Stripe(\'$stripeApiKey\');
    
    stripe.redirectToCheckout({
      sessionId: '$sessionId'
    }).then(function (result) {
        result.error.message = 'Error'
    });
    ''';

    return await _webViewController.evaluateJavascript(redirectToCheckoutJs);
  }
}
