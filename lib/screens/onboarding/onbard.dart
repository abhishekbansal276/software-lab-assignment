import 'package:flutter/material.dart';
import 'package:software_lab_assignment/screens/login/login.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      "image": "assets/onboard_one.png",
      "color": const Color(0xFF5EA25F),
      "title": "Qualify",
      "description":
          "Sell your farm fresh products directly to consumers, cutting out the middleman and reducing emissions of the global supply chain."
    },
    {
      "image": "assets/onboard_two.png",
      "color": const Color(0xFFD5715B),
      "title": "Convenient",
      "description":
          "Our team of delivery drivers will make sure your orders are picked up on time and promptly delivered to your customers."
    },
    {
      "image": "assets/onboard_image.png",
      "color": const Color(0xFFF8C569),
      "title": "Local",
      "description":
          "We love the earth and know you do too! Join us in reducing our local carbon footprint one order at a time."
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onJoinPressed() {
    if (_currentIndex == _pages.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pages[_currentIndex]["color"],
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 40.0)),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0), 
                        child: Image.asset(
                          _pages[index]["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 30),
                              Text(
                                _pages[index]["title"],
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'BeVietnam',
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 20),
                              Text(
                                _pages[index]["description"],
                                style: const TextStyle(
                                  color: Color(0xFF261C12),
                                  fontSize: 14,
                                  fontFamily: 'BeVietnam',
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(_pages.length, (index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    height: 6.0,
                                    width: _currentIndex == index ? 12.0 : 6.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 20),
                              SizedBox(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20.0),
                                    backgroundColor: _pages[index]["color"],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: _onJoinPressed,
                                  child: const Text(
                                    'Join The Movement!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'BeVietnam',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 40),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontFamily: 'BeVietnam',
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
