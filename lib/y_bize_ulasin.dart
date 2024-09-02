import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class bizeulasin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: ContactUs(
          logo: AssetImage('assets/images/Batu.JPG'),
          email: 'batuhan.aydogdu06@gmail.com',
          companyName: 'Batuhan Aydoğdu',
          phoneNumber: '+905536586948',
          dividerThickness: 2,
          website: 'https://www.erbakan.edu.tr/muhendislikvemimarlik',
          githubUserName: 'batwhoan',
          linkedinURL:
              'https://www.linkedin.com/in/batuhan-aydo%C4%9Fdu-268238224/',
          tagLine: 'Flutter Geliştirici',
          textColor: Colors.black,
          cardColor: Color.fromARGB(255, 73, 138, 165),
          companyColor: Color.fromARGB(255, 0, 0, 0),
          taglineColor: Colors.red,
          companyFontSize: 40,
        ),
      ),
    );
  }
}
