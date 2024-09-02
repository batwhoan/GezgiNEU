import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gezgineu/a_menu.dart';

class kayit_ekrani extends StatefulWidget {
  const kayit_ekrani({Key? key}) : super(key: key);

  @override
  State<kayit_ekrani> createState() => _kayit_ekraniState();
}

class _kayit_ekraniState extends State<kayit_ekrani> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  String _email = "";
  String _password = "";

  void _kayitIslemi() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      print("User Registered: ${userCredential.user!.email}");

      // Firestore instance'ı oluştur
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Kullanıcı koleksiyonu referansı
      CollectionReference users = firestore.collection('users');

      // Email'i kontrol et
      QuerySnapshot emailSnapshot =
          await users.where('email', isEqualTo: _email).get();

      // Eğer aynı email adresiyle kayıtlı bir kullanıcı bulunursa hata ver
      if (emailSnapshot.docs.isNotEmpty) {
        throw "Bu hesap zaten kayıtlı!";
      }

      // Kullanıcı bilgilerini Firestore'a ekle
      await users.add({
        'email': _email,
        'uid': userCredential.user!.uid,
      });

      // Kayıt başarılıysa anasayfaya yönlendirme
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => anasayfa(),
        ),
      );
    } catch (e) {
      print("Hata: $e");
      // Hata mesajını göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/magaza_bg.jpg'), // Arka plan resmi burada belirtilir
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "E-posta",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen mail girin";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Şifre",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Lütfen şifre girin";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _kayitIslemi();
                      }
                    },
                    child: Text("Kayıt Ol"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
