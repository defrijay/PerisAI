import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'signup_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/img1.png',
      'title': 'Welcome, to PerisAI',
      'subtitle': 'Your safety, our priority.',
    },
    {
      'image': 'assets/images/img2.png',
      'title': 'Scream Detected?',
      'subtitle': 'We alert police and family instantly.',
    },
    {
      'image': 'assets/images/img3.png',
      'title': 'Can’t Scream?',
      'subtitle': 'Shake your phone to ask for emergency help.',
    },
    {
      'image': 'assets/images/img4.png',
      'title': 'Precise Location',
      'subtitle': 'We tell police and family exactly where you are.',
    },
    {
      'image': 'assets/images/img1.png',
      'title': 'PerisAI',
      'subtitle': 'Security. Anywhere. Anytime.',
    },
  ];

  // void _goToPage(int index) {
  //   if (index >= 0 && index < _pages.length) {
  //     _pageController.animateToPage(
  //       index,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 16, 32),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(page['image']!, height: 220),
                        const SizedBox(height: 30),
                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page['subtitle']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        if (index == _pages.length - 1)
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Sign In'),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const SignupPage()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                                  child: const Text('Sign Up'),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.orange : const Color.fromARGB(60, 17, 74, 123),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     TextButton(
            //       onPressed: _currentPage > 0
            //           ? () => _goToPage(_currentPage - 1)
            //           : null,
            //       child: const Text('← Prev'),
            //     ),
            //     TextButton(
            //       onPressed: _currentPage < _pages.length - 1
            //           ? () => _goToPage(_currentPage + 1)
            //           : null,
            //       child: const Text('Next →'),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
