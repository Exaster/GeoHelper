import 'package:flutter/material.dart';

class WebContentScreen extends StatelessWidget {
  final String url;

  const WebContentScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  WebView({required String initialUrl}) {}
}
