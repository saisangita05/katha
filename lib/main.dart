import 'package:flutter/material.dart';
import 'package:katha/myWidgets/my_navigation.dart';
import 'package:katha/screens/commicPreview.dart';
import 'package:katha/screens/homepage.dart';
import 'package:katha/screens/loginpage.dart';
import 'package:katha/screens/numberpage.dart';
import 'package:katha/screens/otppage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katha',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/number': (context) => NumberPage(),
        '/home': (context) => HomePage(),
        '/otp': (context) => OtpPage(),
        '/navigate' : (context) => NavigationPage(),
        '/preview': (context) => ComicPreviewPage()
      },
    );
  }
}
