import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gezgineu/y_uye_kontrol.dart';

class UIDQRCodeGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Kullanıcının oturum açtığını kontrol edelim
    if (FirebaseAuth.instance.currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('UID QR Code Generator'),
        ),
        body: Center(
          child: Text('Kullanıcı oturum açmamış.'),
        ),
      );
    }

    // Kullanıcının oturum açtığı varsayıldığı için kullanıcının e-posta adresini alalım
    String? userEmail = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Üyelik Kontrol Ekranı'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: userEmail)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Bir hata oluştu: ${snapshot.error}'),
              );
            }

            // Firestore'dan kullanıcı belgesini alalım
            var userDocs = snapshot.data!.docs;

            // Kullanıcı belgesi bulunamadıysa
            if (userDocs.isEmpty) {
              return Center(
                child: Text('Kullanıcı verisi bulunamadı.'),
              );
            }

            // Kullanıcı belgesi bulunduysa, belgeden UID'yi alalım
            var uid = userDocs.first.data()['uid'];

            // UID ile QR kod oluşturalım ve ekrana basalım
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImageView(
                    data: uid,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: CircleBorder(),
                      minimumSize: Size(75, 75),
                    ),
                    onPressed: () {
                      // Butona tıklandığında istediğiniz sayfayı açın
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QRScannerScreen()),
                      );
                    },
                    child: Text('Kod Tara'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
