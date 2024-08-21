import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:software_lab_assignment/screens/login/login.dart';
import 'package:software_lab_assignment/screens/login/reset_password.dart';
import 'package:software_lab_assignment/services/api_service.dart';

class OTP extends StatefulWidget {
  final String phoneNumber;
  const OTP({super.key, required this.phoneNumber});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final ApiService _apiService = ApiService();
  String _otp = '';

  void _verifyOtp() async {
    if (_otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the OTP.'),
        ),
      );
      return;
    }

    try {
      await _apiService.verifyOtp(otp: _otp);
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => ResetPassword(otp: _otp),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _resendCode() async {
    final mobileNumber = widget.phoneNumber;
    try {
      await _apiService.forgotPassword(mobile: mobileNumber);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP resent successfully.'),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width / 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                const Text(
                  'FarmerEats',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: height / 10),
                const Text(
                  'Verify OTP',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height / 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Remember your password?  ',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style:
                              TextStyle(color: Color(0xFFD5715B), fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height / 10),
                OTPTextField(
                  length: 5,
                  width: width,
                  fieldWidth: 50,
                  style: const TextStyle(fontSize: 20),
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  fieldStyle: FieldStyle.box,
                  otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Colors.grey[200]!,
                    borderColor: Colors.transparent,
                  ),
                  onCompleted: (pin) {
                    setState(() {
                      _otp = pin;
                    });
                  },
                ),
                SizedBox(height: height / 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFFD5715B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: _verifyOtp,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height / 30),
                Center(
                  child: GestureDetector(
                    onTap: _resendCode,
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
