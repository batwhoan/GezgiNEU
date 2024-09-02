import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class tarih extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/tarih.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              _buildElevatedButton(105, 130,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=27'),
              _buildElevatedButton(105, 4,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=1524'),
              _buildElevatedButton(800, 0,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=T31'),
              _buildElevatedButton(800, 110,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=T37'),
              _buildElevatedButtonWithBorderRadius(63, 255,
                  'https://www.google.com/maps/place/Atat%C3%BCrk+M%C3%BCzesi/@37.869125,32.4827417,17.17z/data=!4m6!3m5!1s0x14d085a95e47be3d:0x213f904f7b9a62ef!8m2!3d37.870203!4d32.4878018!16s%2Fg%2F1tg9vy6n?entry=ttu'),
              _buildElevatedButtonWithBorderRadius(245, 135,
                  'https://www.google.com/maps/place/Konya+Etnografya+M%C3%BCzesi/@37.8667003,32.4890084,17z/data=!3m1!4b1!4m6!3m5!1s0x14d085aa87654227:0xfffef2c2ce3ee40a!8m2!3d37.8666961!4d32.4915833!16s%2Fg%2F12hhj28jp?entry=ttu'),
              _buildElevatedButtonWithBorderRadius(420, 165,
                  'https://www.google.com/maps/place/Konya+Arkeoloji+M%C3%BCzesi/@37.8679844,32.4909351,17z/data=!3m1!4b1!4m6!3m5!1s0x14d08500b8f14a59:0x8d3cbb08881bc0c!8m2!3d37.8679802!4d32.49351!16s%2Fg%2F1hb_gn7m0?entry=ttu'),
              _buildElevatedButtonWithBorderRadius(600, 115,
                  'https://www.google.com/maps/place/S%C4%B1r%C3%A7al%C4%B1+Medrese/@37.8700532,32.4914431,17z/data=!3m1!4b1!4m6!3m5!1s0x14d08452d4d5191d:0x6c4cb9fe8697829a!8m2!3d37.870049!4d32.494018!16s%2Fm%2F0w6hrlm?entry=ttu'),
              _buildElevatedButtonWithBorderRadius(780, 220,
                  'https://www.google.com/maps/place/Panorama+Konya+M%C3%BCzesi/@37.8700156,32.509191,17z/data=!3m1!4b1!4m6!3m5!1s0x14d08516ff42bc29:0x6921ad5afde8339!8m2!3d37.8700114!4d32.5117659!16s%2Fg%2F11hbg8cjty?entry=ttu'),
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
          shadowColor: Colors.transparent,
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
          _launchurl(url);
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

_launchurl(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: false, enableJavaScript: true);
  } else {
    throw 'Could not launch $url';
  }
}
