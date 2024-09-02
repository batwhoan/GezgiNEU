import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class magaza extends StatefulWidget {
  @override
  _magazaState createState() => _magazaState();
}

class _magazaState extends State<magaza> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? imageUrl;
  String? text;
  String? text2;
  String? fiyat;

  int currentDocumentIndex = 1;
  int totalCount = 0;

  @override
  void initState() {
    super.initState();
    _loadTotalCount();
    _loadData(currentDocumentIndex);
    _loadAdditionalData(currentDocumentIndex);
  }

  Future<void> _loadData(int documentIndex) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('magazalar').doc('$documentIndex').get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null &&
            data.containsKey('resim_url') &&
            data.containsKey('metin') &&
            data.containsKey('fiyat')) {
          setState(() {
            imageUrl = data['resim_url'];
            text = data['metin'];
            fiyat = data['fiyat'];
          });
        } else {
          print('Firestore verisi eksik');
        }
      } else {
        print('Belge bulunamadı');
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Future<void> _loadAdditionalData(int documentIndex) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('magazalar').doc('$documentIndex').get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('metin2')) {
          setState(() {
            text2 = data['metin2'];
          });
        } else {
          print('Ek verisi eksik');
        }
      } else {
        print('Belge bulunamadı');
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Future<void> _loadTotalCount() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('magazalar').get();
      totalCount = querySnapshot.docs.length;
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  void _openWebsite(String? websiteUrl) async {
    try {
      if (websiteUrl != null && await canLaunch(websiteUrl)) {
        await launch(websiteUrl);
      } else {
        throw 'Geçersiz URL';
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/magaza_arkaplan.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text ?? '',
                          style: TextStyle(
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(
                                255, 255, 255, 255), // Metin rengi
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.2,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Kutu rengi
                      borderRadius:
                          BorderRadius.circular(30), // Kenar yumuşatma
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 255, 255, 255), // Metin kutusu rengi
                        borderRadius:
                            BorderRadius.circular(15), // Kenar yumuşatma
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text2 ?? '',
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(
                                255, 0, 0, 0), // Metin rengi
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 40,
              child: GestureDetector(
                onTap: () {
                  currentDocumentIndex++;
                  if (currentDocumentIndex > totalCount) {
                    currentDocumentIndex = 1;
                  }
                  _loadData(currentDocumentIndex);
                  _loadAdditionalData(currentDocumentIndex);
                },
                child: Image.asset(
                  "assets/images/sonraki_magaza.png",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 40,
              child: GestureDetector(
                onTap: () {
                  _openWebsiteButton();
                },
                child: Image.asset(
                  "assets/images/konum.png",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openWebsiteButton() async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('magazalar')
          .doc('$currentDocumentIndex')
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('internet_sitesi')) {
          String? websiteUrl = data['internet_sitesi'];
          _openWebsite(websiteUrl);
        } else {
          print('Belgede internet sitesi linki eksik');
        }
      } else {
        print('Belge bulunamadı');
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }
}
