import 'package:flutter/material.dart';
import 'onboarding.dart'; // pastikan path-nya benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PerisAI',
      theme: ThemeData.dark(), // opsional, biar gelap
      home: const OnboardingScreen(),
    );
  }
}
