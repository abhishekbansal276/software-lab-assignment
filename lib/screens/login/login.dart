import 'package:flutter/material.dart';
import 'package:software_lab_assignment/screens/home/home.dart';
import 'package:software_lab_assignment/screens/login/forget_password.dart';
import 'package:software_lab_assignment/screens/signup/signup.dart';
import 'package:software_lab_assignment/services/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(width / 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Text(
              'FarmerEats',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: height / 8),
            const Text(
              'Welcome back!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height / 35),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                );
              },
              child: const Text.rich(
                TextSpan(
                  text: 'New here? ',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Create account',
                      style: TextStyle(color: Color(0xFFD5715B), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height / 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                            size: 18,
                          ),
                          SizedBox(width: width / 30),
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email Address',
                                hintStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 50),
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
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPassword(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot?',
                              style: TextStyle(
                                  color: Color(0xFFD5715B), fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height / 20),
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
                        onPressed: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    'Please enter both email and password'),
                                backgroundColor: Colors.grey[200]!,
                              ),
                            );
                            return;
                          }

                          final apiService = ApiService();

                          try {
                            final response = await apiService.loginUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                              role: 'farmer',
                              deviceToken: '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx',
                              type: 'email',
                              socialId: '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx',
                            );

                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(response),
                                backgroundColor: Colors.grey[200],
                              ),
                            );
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height / 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'or login with',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
            SizedBox(height: height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(
                  'assets/google.png',
                  height / 20,
                  width / 10,
                  () async {
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
                  },
                ),
                _buildSocialButton('assets/apple.png', height / 20, width / 10,
                    () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Apple signin not available')),
                  );
                }),
                _buildSocialButton(
                    'assets/facebook.png', height / 20, width / 10, () async {
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
          ],
        ),
      ),
    );
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
}
