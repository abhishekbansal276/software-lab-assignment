import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Software Lab Assignment',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFD5715B),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(width / 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Color(0xFFD5715B),
            ),
            SizedBox(height: height / 30),
            const Text(
              'Assignment Completed Successfully',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
