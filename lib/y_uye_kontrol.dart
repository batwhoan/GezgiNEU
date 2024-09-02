import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool showAlert = false;
  String scannedText = '';
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Üyelik Kontrol'),
      ),
      body: Stack(
        children: [
          _buildQrView(context),
          if (showAlert) _buildAlert(),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  Widget _buildAlert() {
    return Positioned.fill(
      child: Container(
        color: Colors.black87.withOpacity(0.5),
        child: AlertDialog(
          title: Text('Üyelik Kontrol'),
          content: Text(scannedText),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showAlert = false;
                });
              },
              child: Text('Kapat'),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      final qrCode = scanData.code!;
      final userDocs =
          await usersCollection.where('uid', isEqualTo: qrCode).get();
      setState(() {
        if (userDocs.docs.isNotEmpty) {
          showAlert = true;
          scannedText = 'Kullanıcı onaylandı!';
        } else {
          showAlert = true;
          scannedText = 'Kullanıcı onaylanmadı!';
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
