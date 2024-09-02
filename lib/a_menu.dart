import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gezgineu/y_bize_ulasin.dart';
import 'package:gezgineu/m_nobetci_eczane.dart';
import 'package:gezgineu/m_akademik_takvimler.dart';
import 'package:gezgineu/m_dost_restoranlar.dart';
import 'package:gezgineu/m_dost_k%C4%B1rtasiyeler.dart';
import 'package:gezgineu/m_dost_magazalar.dart';
import 'package:gezgineu/y_uye_id.dart';
import 'package:gezgineu/m_rotalar.dart';
import 'package:gezgineu/m_gunun_yemegi.dart';

class anasayfa extends StatefulWidget {
  const anasayfa({Key? key}) : super(key: key);

  @override
  State<anasayfa> createState() => _anasayfaState();
}

// ignore: camel_case_types
class _anasayfaState extends State<anasayfa> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String _backgroundImage = "assets/images/bg1.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 64, 138, 158)),
        ),
        title: Text('HOŞGELDİNİZ'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                5,
                5,
                5,
                0,
              ),
              child: GridView.count(
                crossAxisSpacing: 25,
                mainAxisSpacing: 40,
                crossAxisCount: 2,
                childAspectRatio: 0.95,
                children: [
                  _buildMenuItem(
                    context,
                    "assets/images/rota.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => rotalar()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "assets/images/eczane.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => nobetci_eczane()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "assets/images/takvim.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => akademik_takvimler()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "assets/images/lunch.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => yemekhane()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "assets/images/restoran.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => restoran()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "assets/images/kirtasiye.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => kirtasiye()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    "assets/images/magaza.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => magaza()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(),
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      _backgroundImage,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String imagePath, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        height: 80, // Buton yüksekliği burada 120 olarak ayarlanmıştır.
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 64, 138, 158)),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                'Menü',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            ListTile(
              title: Text(
                'Üyelik Kontrol',
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0), fontSize: 40),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UIDQRCodeGenerator()),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text(
                'Bize Ulaşın',
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0), fontSize: 40),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => bizeulasin()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
