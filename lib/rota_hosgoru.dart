import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class hosgoru extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/hosgoru.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              _buildElevatedButton(105, 202,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=56'),
              _buildElevatedButton(105, 45,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=1524'),
              _buildElevatedButton(270, 267,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=26'),
              _buildElevatedButton(455, 80,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=2424'),
              _buildElevatedButton(635, 59,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=T37'),
              _buildElevatedButton(635, 231,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=T31'),
              _buildElevatedButtonWithBorderRadius(0, 265,
                  'https://www.google.com/maps/dir//Arma%C4%9Fan,+42090+Meram%2FKonya/@37.8720267,32.3841499,12z/data=!4m8!4m7!1m0!1m5!1m1!1s0x14d085cb2a7f2fa9:0xeaf9bda0fc036a69!2m2!1d32.466553!2d37.8718993?entry=ttu'),
              _buildElevatedButtonWithBorderRadius(
                  240, 140, 'https://website8.com'),
              _buildElevatedButtonWithBorderRadius(
                  420, 227, 'https://website9.com'),
              _buildElevatedButtonWithBorderRadius(
                  780, 99, 'https://website10.com'),
            ],
          ),
        ),
      ),
    );
  }

  // ElevetadButton oluşturmak için yardımcı fonksiyon
  Widget _buildElevatedButton(double top, double left, String url) {
    return Positioned(
      top: top,
      left: left,
      child: ElevatedButton(
        onPressed: () {
          _launchURL(url);
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(34),
          primary: Colors.transparent,
          shadowColor: Colors.red,
          elevation: 0,
        ),
        child: SizedBox(),
      ),
    );
  }

  // BorderRadius ile birlikte ElevatedButton oluşturmak için yardımcı fonksiyon
  Widget _buildElevatedButtonWithBorderRadius(
      double top, double left, String url) {
    return Positioned(
      top: top,
      left: left,
      child: ElevatedButton(
        onPressed: () {
          _launchURL(url);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          padding: EdgeInsets.fromLTRB(100, 50, 45, 50),
          primary: Colors.transparent,
          shadowColor: const Color.fromARGB(0, 255, 1, 1),
          elevation: 0,
        ),
        child: SizedBox(),
      ),
    );
  }

  // Özel işlev: URL'yi aç
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
