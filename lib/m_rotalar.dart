import 'package:flutter/material.dart';
import 'package:gezgineu/rota_hosgoru.dart';
import 'package:gezgineu/rota_genclik.dart';
import 'package:gezgineu/rota_tarih.dart';
import 'package:gezgineu/rota_yesil.dart';

class rotalar extends StatefulWidget {
  @override
  _RotalarState createState() => _RotalarState();
}

class _RotalarState extends State<rotalar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAlertDialog(context);
    });
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Bir Saniye"),
          content: Text(
              "Durakların üzerine dokunarak duraklardaki otobüs bilgisini, mekanların üzerine dokunarak ise mekanın haritadaki konumlarına ulaşabilirsiniz. İyi gezmeler."),
          actions: [
            TextButton(
              child: Text("Hadi Başlayalım"),
              onPressed: () {
                Navigator.of(context).pop(); // Mesajı kapat
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 64, 138, 158),
        title: Text("Rotalar"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/rota_arkaplan.png'), // Arka plan resmi
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => hosgoru()),
                  );
                },
                child: SizedBox(
                  height: 150.0,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/hosgoru_kapak.png',
                    width: double.infinity,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => genclik()),
                  );
                },
                child: SizedBox(
                  height: 150.0,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/genclik_kapak.png',
                    width: double.infinity,
                    height: 120.0,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => tarih()),
                  );
                },
                child: SizedBox(
                  height: 150.0,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/tarih_kapak.png',
                    width: double.infinity,
                    height: 100.0,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => yesil()),
                  );
                },
                child: SizedBox(
                  height: 150.0,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/yesil_kapak.png',
                    width: double.infinity,
                    height: 100.0,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
