import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class yemekhane extends StatefulWidget {
  const yemekhane({super.key});

  @override
  State<yemekhane> createState() => _yemekhaneState();
}

class _yemekhaneState extends State<yemekhane> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://kampuskart.erbakan.edu.tr/"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 64, 138, 158),
        centerTitle: true,
        title: Text("KAMPÜS KART"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
