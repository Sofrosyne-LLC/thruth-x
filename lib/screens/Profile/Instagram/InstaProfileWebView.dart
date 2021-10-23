import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class InstaProfileWebView extends StatefulWidget {
  final String profileUrl;
  InstaProfileWebView(this.profileUrl);
  @override
  _InstaProfileWebViewState createState() => _InstaProfileWebViewState();
}

class _InstaProfileWebViewState extends State<InstaProfileWebView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.profileUrl,
      appBar: new AppBar(),
      withLocalStorage: true,
      initialChild: Container(
        child: Center(
          child: Image.asset(
            'assets/instagram.png',
            height: 36,
          ),
        ),
      ),
    );
  }
}
