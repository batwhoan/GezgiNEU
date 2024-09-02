import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class kirtasiye extends StatefulWidget {
  @override
  _kirtasiyeState createState() => _kirtasiyeState();
}

class _kirtasiyeState extends State<kirtasiye> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? imageUrl;
  String? text;
  String? text2;
  String? menuUrl;
  String? fiyat;
  int currentDocumentIndex = 1;
  int totalCount = 0;

  Future<void> _loadData(int documentIndex) async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('kirtasiyeler')
          .doc('$documentIndex')
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null &&
            data.containsKey('resim_url') &&
            data.containsKey('metin') &&
            data.containsKey('fiyat')) {
          setState(() {
            imageUrl = data['resim_url'];
            text = data['metin'];
            menuUrl = data['internet_sitesi'];
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
      DocumentSnapshot snapshot = await _firestore
          .collection('kirtasiyeler')
          .doc('$documentIndex')
          .get();
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

  @override
  void initState() {
    super.initState();
    _loadTotalCount();
    _loadData(currentDocumentIndex);
    _loadAdditionalData(currentDocumentIndex);
  }

  Future<void> _loadTotalCount() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('kirtasiyeler').get();
      totalCount = querySnapshot.docs.length;
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  void _openMyWebsite(String? websiteUrl) async {
    if (websiteUrl != null) {
      if (await canLaunch(websiteUrl)) {
        await launch(websiteUrl);
      } else {
        throw 'İnternet sitesi açılamadı: $websiteUrl';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/kırtasiye_arkaplan.png"),
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
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          text ?? '',
                          style: TextStyle(
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 252, 252, 252),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          text2 ?? '',
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 0, 0, 0),
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
              bottom: 10,
              right: 20,
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
                  "assets/images/gonye.png",
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 30,
              child: GestureDetector(
                onTap: () {
                  _openMyWebsite(menuUrl);
                },
                child: Image.asset(
                  "assets/images/konum.png",
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
