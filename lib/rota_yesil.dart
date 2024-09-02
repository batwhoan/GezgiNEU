import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class yesil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/yesil.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              _buildElevatedButton(103, 152,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=1524'),
              _buildElevatedButton(103, 1,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=48'),
              _buildElevatedButton(275, 166,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=11'),
              _buildElevatedButton(275, 278,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=48'),
              _buildElevatedButton(445, 65,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=11'),
              _buildElevatedButton(445, 200,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=2415'),
              _buildElevatedButton(810, 5,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=2419'),
              _buildElevatedButton(810, 96,
                  'https://atus.konya.bel.tr/atus/otobusum-nerede?durakNo=1701'),
              _buildElevatedButtonWithBorderRadius(70, 250,
                  'https://www.google.com.tr/maps/place/KONYA+MERAM+BA%C4%9ELARI/@37.8526593,32.418524,17z/data=!4m6!3m5!1s0x14d087bfc6295397:0xe6490bd288f5a12c!8m2!3d37.8526815!4d32.4201707!16s%2Fg%2F11h4w1794z?hl=tr&entry=ttu'),
              _buildElevatedButtonWithBorderRadius(248, 3,
                  'https://www.google.com.tr/maps/place/MERAM+M%C4%B0LLET+BAH%C3%87ES%C4%B0/@37.8655154,32.4809281,17z/data=!4m10!1m2!2m1!1smillet+bah%C3%A7esi!3m6!1s0x14d0859c8278039d:0x6c76bf50cd171193!8m2!3d37.8658248!4d32.4840929!15sCg9taWxsZXQgYmFow6dlc2laESIPbWlsbGV0IGJhaMOnZXNpkgEEcGFya5oBI0NoWkRTVWhOTUc5blMwVkpRMEZuU1VSU2ExOXFiV04zRUFF4AEA!16s%2Fg%2F11sccb647d?hl=tr&entry=ttu'),
              _buildElevatedButtonWithBorderRadius(445, 282,
                  'https://www.google.com.tr/maps/place/Alaaddin+Tepesi+Park%C4%B1/@37.8725165,32.4923363,17z/data=!3m1!4b1!4m6!3m5!1s0x14d085a82ab352ad:0x361fb79cc1c486b0!8m2!3d37.8725165!4d32.4923363!16s%2Fg%2F11mvrm9gm?hl=tr&entry=ttu'),
              _buildElevatedButtonWithBorderRadius(605, 110,
                  'https://www.google.com.tr/maps/place/K%C3%BClt%C3%BCr+Park/@37.8751193,32.486574,17z/data=!3m1!4b1!4m6!3m5!1s0x14d085a632d6cd91:0xa29477839fe600e8!8m2!3d37.8751151!4d32.4891489!16s%2Fg%2F11bxd_x_d0?hl=tr&entry=ttu'),
              _buildElevatedButtonWithBorderRadius(780, 215,
                  'https://www.google.com.tr/maps/place/Sille+Baraj+Park%C4%B1/@37.9280915,32.4024964,17z/data=!3m1!4b1!4m6!3m5!1s0x14d087d550d65be7:0xeb1b6a4dc4b74ee!8m2!3d37.9280915!4d32.4024964!16s%2Fg%2F11fx_5fdd8?hl=tr&entry=ttu'),
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
