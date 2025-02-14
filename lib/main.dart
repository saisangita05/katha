import 'package:flutter/material.dart';
import 'package:katha/screens/loginpage.dart';
import 'package:katha/screens/library.dart'; // Import LibraryPage
import 'package:katha/screens/numberpage.dart';
import 'package:katha/screens/otppage.dart';
import 'package:katha/screens/homepage.dart';
import 'package:katha/screens/commicPreview.dart';
import 'package:katha/myWidgets/my_navigation.dart';
import 'package:katha/supabase_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseClientSetup.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katha',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/number': (context) => NumberPage(),
        '/otp': (context) => OtpPage(),
        '/home': (context) => HomePage(),
        '/navigate': (context) => NavigationPage(),
        '/preview': (context) => ComicPreviewPage(),
        '/library': (context) => LibraryPage(), // Added Library Page Route
      },
    );
  }
}
