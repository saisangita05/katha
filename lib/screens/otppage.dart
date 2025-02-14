import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  bool isLoading = false;
  String verificationId = '';
  String phoneNumber = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    phoneNumber = args['phoneNumber'] ?? '';
    verificationId = args['verificationId'] ?? '';
  }

  void _verifyOtp() async {
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length < 6) {
      _showError("Enter complete OTP");
      return;
    }

    setState(() => isLoading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      Navigator.pushNamed(context, '/navigate'); // Navigate to next screen on success
    } catch (e) {
      _showError("Invalid OTP. Try again.");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _resendOtp() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.pushNamed(context, '/navigate');
      },
      verificationFailed: (FirebaseAuthException e) {
        _showError("Verification failed. Try again.");
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() => this.verificationId = verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

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
                  child: Icon(Icons.arrow_back_ios_sharp, size: 20, color: Colors.white),
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
                    'Enter the OTP sent to',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    phoneNumber, // Dynamically displaying the phone number
                    style: TextStyle(color: Color(0xFFA3D749), fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _otpControllers[index],
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
                  isLoading
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
                      onPressed: _verifyOtp,
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
                    onTap: _resendOtp,
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
