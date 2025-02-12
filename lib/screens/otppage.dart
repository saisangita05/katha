import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpPage extends StatefulWidget {

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 65, horizontal: 20),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[600],
                ),
                child: Center(
                  child: Icon(Icons.arrow_back_ios_sharp, size: 20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'katha',
                    style: GoogleFonts.cormorantUnicase(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA3D749),
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 80),
                  Text(
                    'Enter your OTP sent to',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    "+912345678", // Dynamic phone number
                    style: TextStyle(color: Color(0xFFA3D749), fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            // controller: _controllers[index],
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            showCursor: false,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 30),
                  false
                      ? CircularProgressIndicator(color: Color(0xFFA3D749))
                      : SizedBox(
                    width: 300,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFFA3D749)),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // onPressed: _verifyOtp,
                      onPressed: ()=>{
                        Navigator.pushNamed(context, '/navigate')
                      },
                      child: Text(
                        'Verify OTP',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Didn't receive OTP?",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add resend OTP logic here if needed
                    },
                    child: Text(
                      'Resend it!',
                      style: TextStyle(
                        color: Color(0xFFA3D749),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
