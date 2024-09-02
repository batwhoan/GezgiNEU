import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class akademik_takvimler extends StatefulWidget {
  const akademik_takvimler({Key? key});

  @override
  State<akademik_takvimler> createState() => _akademik_takvimlerState();
}

class _akademik_takvimlerState extends State<akademik_takvimler> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> pdfUrls = ["", "", "", "", ""];
  List<String> imageUrls = ["", "", "", "", ""];
  List<String> uniAdList = ["", "", "", "", ""];

  @override
  void initState() {
    super.initState();
    _getPdfAndImageUrls();
    _getUniAd();
  }

  Future<void> _getPdfAndImageUrls() async {
    try {
      for (int i = 1; i <= 5; i++) {
        DocumentSnapshot snapshot =
            await _firestore.collection('takvimler').doc('takvim_$i').get();
        if (snapshot.exists) {
          setState(() {
            pdfUrls[i - 1] = snapshot['pdf_url'];
            imageUrls[i - 1] = snapshot['image_url'];
          });
        } else {
          print('Belge bulunamadı: takvim_$i');
        }
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Future<void> _getUniAd() async {
    try {
      for (int j = 1; j <= 5; j++) {
        DocumentSnapshot snapshot =
            await _firestore.collection('takvimler').doc('takvim_$j').get();
        if (snapshot.exists) {
          setState(() {
            uniAdList[j - 1] = snapshot['UniAd'];
          });
        } else {
          print('Üniversite adı bulunamadı.');
        }
      }
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Widget _buildMenuItem(
      BuildContext context, String pdfUrl, String imageUrl, String uniAd) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerPage(pdfUrl: pdfUrl),
            ),
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 24,
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(
                uniAd,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 64, 138, 158)),
        ),
        centerTitle: true,
        title: const Text("Akademik Takvimler"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/akademik_arkaplan.png'), // Arka plan resmi
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: List.generate(
                    pdfUrls.length,
                    (index) => _buildMenuItem(
                      context,
                      pdfUrls[index],
                      imageUrls[index],
                      uniAdList[index],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  PdfViewerPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color.fromARGB(255, 243, 33, 33),
                Color.fromARGB(147, 76, 116, 175),
              ],
            ),
          ),
        ),
        title: Text('AKADEMİK TAKVİM'),
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
