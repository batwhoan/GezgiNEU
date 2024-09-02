import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart'; // Eklenen kütüphane

class restoran extends StatefulWidget {
  @override
  _restoranState createState() => _restoranState();
}

class _restoranState extends State<restoran> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? imageUrl;
  String? text;
  String? text2;
  String? websiteUrl;
  String? menu;
  int currentDocumentIndex = 1;
  int totalCount = 0;

  Future<void> _loadData(int documentIndex) async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('restoranlar')
          .doc('$documentIndex')
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null &&
            data.containsKey('resim_url') &&
            data.containsKey('metin') &&
            data.containsKey('internet_sitesi') &&
            data.containsKey('menu')) {
          setState(() {
            imageUrl = data['resim_url'];
            text = data['metin'];
            websiteUrl = data['internet_sitesi'];
            menu = data['menu']; // websiteUrl'e internet sitesi ekleniyor
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
          .collection('restoranlar')
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
          await _firestore.collection('restoranlar').get();
      totalCount = querySnapshot.docs.length;
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  void _showImage(BuildContext context) {
    if (imageUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: PhotoView(
                imageProvider: NetworkImage(menu!),
                backgroundDecoration: BoxDecoration(
                  color: Colors.black,
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                initialScale: PhotoViewComputedScale.contained,
              ),
            ),
          ),
        ),
      );
    }
  }

  void _openMyWebsite() async {
    if (websiteUrl != null) {
      if (await canLaunch(websiteUrl!)) {
        await launch(websiteUrl!);
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
            image: AssetImage("assets/images/restoran_arkaplan.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    child: Text(
                      text ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
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
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 202, 192, 189),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      text2 ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
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
                  "assets/images/sonraki.png",
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  _showImage(context);
                },
                child: Image.asset(
                  "assets/images/menu.png",
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 170,
              child: GestureDetector(
                onTap: () {
                  _openMyWebsite();
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
