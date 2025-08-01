import 'package:flutter/material.dart';
import 'onboarding.dart';
import 'package:flutter_application_1/pages/home/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PerisAI Onboarding',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
