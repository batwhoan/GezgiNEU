import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class genclik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/genclik.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              _buildElevatedButton(105, 144,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=27'),
              _buildElevatedButton(105, 4,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=1524'),
              _buildElevatedButton(105, 278,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=T30'),
              _buildElevatedButton(270, 285,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=T26'),
              _buildElevatedButton(450, 71,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=T18'),
              _buildElevatedButton(624, 68,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=T3'),
              _buildElevatedButton(630, 267,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=T18'),
              _buildElevatedButtonWithBorderRadius(250, 98,
                  'https://www.google.com.tr/maps/place/Enntepe+Mall+Office/@37.8861465,32.4981802,17z/data=!4m6!3m5!1s0x14d0856a7b500b6d:0xb19f1f4bc78d166d!8m2!3d37.8864767!4d32.4988883!16s%2Fg%2F11h5rd9vy5?hl=tr&entry=ttu'),
              _buildElevatedButtonWithBorderRadius(420, 200,
                  'https://www.google.com.tr/maps/place/Rz+Arena+(Canl%C4%B1+Counter+%7C+Laser+Tag)/@37.897869,32.4541917,13z/data=!4m10!1m2!2m1!1s%C3%A7alikkayalar+lazer+tag!3m6!1s0x14d08fb0de73aa4f:0x64e44df75f065d4f!8m2!3d37.927839!4d32.507863!15sChfDp2VsaWtrYXlhbGFyIGxhc2VyIHRhZyIDiAEBkgEQYW11c2VtZW50X2NlbnRlcuABAA!16s%2Fg%2F11c6v3bmld?hl=tr&entry=ttu'),
              _buildElevatedButtonWithBorderRadius(780, 99,
                  'https://www.google.com.tr/maps/place/Bowling+Planet/@38.0104497,32.5158857,17z/data=!3m1!4b1!4m6!3m5!1s0x14d08d42f4fc22e9:0x71689532d13328af!8m2!3d38.0104456!4d32.5207566!16s%2Fg%2F11j48h6t3h?hl=tr&entry=ttu'),
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
