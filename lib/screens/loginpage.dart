import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Color(0xFFA3D749), // Updated green background
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 3),

            // App Name with Cormorant Unicase Font
            Text(
              'katha',
              style: GoogleFonts.cormorantUnicase(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.5,
              ),
            ),

            SizedBox(height:0),

            // Subtitle
            Text(
              "india's #1 webtoon platform",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            Spacer(flex: 4),

            // Continue with Phone Number Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Black button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/number'); // Navigate to NumberPage
                },
                child: Text(
                  'Continue with Phone Number',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 15),

            // Continue as Guest Button
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/navigate');
          },


        child: Text(
                'Continue as a guest',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}