import 'package:flutter/material.dart';
import 'package:software_lab_assignment/screens/login/login.dart';
import 'package:software_lab_assignment/services/api_service.dart';

class ResetPassword extends StatefulWidget {
  final String otp;
  const ResetPassword({super.key, required this.otp});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final ApiService _apiService = ApiService();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _resetPassword() async {
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both fields.')),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    try {
      await _apiService.resetPassword(
        token: widget.otp,
        password: newPassword,
        cpassword: confirmPassword,
      );
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
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
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              'Reset Password',
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
                      style: TextStyle(color: Color(0xFFD5715B), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height / 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                    size: 18,
                  ),
                  SizedBox(width: width / 30),
                  Expanded(
                    child: TextField(
                      controller: _newPasswordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'New Password',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height / 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lock_outline,
                    color: Colors.black54,
                    size: 18,
                  ),
                  SizedBox(width: width / 30),
                  Expanded(
                    child: TextField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
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
                onPressed: _resetPassword,
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
