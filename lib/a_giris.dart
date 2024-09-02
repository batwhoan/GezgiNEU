import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'a_menu.dart';
import 'a_kayit_ol.dart'; // Kayıt ekranını import ediyoruz

class giris_ekrani extends StatefulWidget {
  const giris_ekrani({Key? key}) : super(key: key);

  @override
  State<giris_ekrani> createState() => _giris_ekraniState();
}

class _giris_ekraniState extends State<giris_ekrani> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  String _email = "";
  String _password = "";

  void _giris_islemi() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      print("User LOGGED: ${userCredential.user!.email}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => anasayfa(),
        ),
      );
    } catch (e) {
      print("error during LOGIN $e ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 241, 248),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/bg1.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logomm.png",
                    height: 250,
                    width: 250,
                  ),
                  SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: Color.fromARGB(255, 48, 142, 161),
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            icon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 30,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 250, 250, 250),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(171, 44, 44, 44),
                              fontSize: 20,
                            ),
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            filled: true,
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
                          cursorRadius: Radius.circular(10.0),
                          cursorColor: Colors.blue,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passController,
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            icon: Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 30,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 253, 0, 0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            labelText: "Şifre",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(171, 0, 0, 0),
                              fontSize: 20,
                            ),
                            fillColor: Colors.white,
                            filled: true,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _giris_islemi();
                                }
                              },
                              child: Text(
                                'Giriş Yap',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 37, 38, 39),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 10), // Boşluk ekledik
                            ElevatedButton(
                              onPressed: () {
                                // Kayıt ekranına yönlendirme işlemi
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => kayit_ekrani(),
                                  ),
                                );
                              },
                              child: Text(
                                'Kayıt Ol',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 37, 38, 39),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
