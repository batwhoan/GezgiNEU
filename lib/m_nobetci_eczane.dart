import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class nobetci_eczane extends StatefulWidget {
  const nobetci_eczane({super.key});

  @override
  State<nobetci_eczane> createState() => _nobetci_eczaneState();
}

class _nobetci_eczaneState extends State<nobetci_eczane> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://www.konyanobetcieczaneleri.com/"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 64, 138, 158),
        centerTitle: true,
        title: Text("Nöbetçi Eczaneler"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
