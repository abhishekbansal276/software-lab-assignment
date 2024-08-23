import 'package:flutter/material.dart';
import 'package:software_lab_assignment/components/input_box.dart';
import 'package:software_lab_assignment/screens/home/home.dart';
import 'package:software_lab_assignment/screens/login/login.dart';
import 'package:software_lab_assignment/screens/signup/farm_info.dart';
import 'package:software_lab_assignment/models/signup_model.dart';
import 'package:software_lab_assignment/services/api_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(width / 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                const Text(
                  'FarmerEats',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: height / 25),
                Text(
                  'Signup 1 of 4',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),
                SizedBox(height: height / 60),
                const Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height / 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSocialButton(
                        'assets/google.png', height / 20, width / 10, () async {
                      final apiService = ApiService();

                      try {
                        await apiService.signInWithGoogle();
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }),
                    _buildSocialButton(
                        'assets/apple.png', height / 20, width / 10, () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Apple signin not available')),
                      );
                    }),
                    _buildSocialButton(
                        'assets/facebook.png', height / 20, width / 10,
                        () async {
                      final apiService = ApiService();

                      try {
                        await apiService.signInWithFacebook();
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        print(e);
                      }
                    }),
                  ],
                ),
                SizedBox(height: height / 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'or sign up with',
                      style:
                          TextStyle(fontSize: 10, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: width / 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputBox(
                    width: width,
                    icon: Icons.person_outline,
                    hintText: "Full Name",
                    controller: _fullNameController,
                  ),
                  SizedBox(height: height / 40),
                  InputBox(
                    width: width,
                    icon: Icons.email_outlined,
                    hintText: "Email Address",
                    controller: _emailController,
                  ),
                  SizedBox(height: height / 40),
                  InputBox(
                    width: width,
                    icon: Icons.phone_outlined,
                    hintText: "Phone Number",
                    controller: _phoneController,
                  ),
                  SizedBox(height: height / 40),
                  InputBox(
                    width: width,
                    icon: Icons.lock_outline,
                    hintText: "Password",
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: height / 40),
                  InputBox(
                    width: width,
                    icon: Icons.lock_outline,
                    hintText: "Re-Enter Password",
                    controller: _repasswordController,
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width / 12, vertical: height / 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: width / 30, horizontal: width / 5),
                      backgroundColor: const Color(0xFFD5715B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      if (_validateForm()) {
                        final signUpData = SignUpModel(
                          fullName: _fullNameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          password: _passwordController.text,
                          repassword: _repasswordController.text,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FarmInfo(signUpData: signUpData),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Continue',
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
        ],
      ),
    );
  }

  bool _validateForm() {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _repasswordController.text.isEmpty) {
      _showErrorDialog('Please fill in all fields.');
      return false;
    }

    if (_passwordController.text != _repasswordController.text) {
      _showErrorDialog('Passwords do not match.');
      return false;
    }

    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildSocialButton(
    String assetPath, double width, double height, void Function() onTap) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 0.5),
        borderRadius: BorderRadius.circular(100)),
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Image.asset(
          assetPath,
          width: width,
          height: height,
        ),
      ),
    ),
  );
}
