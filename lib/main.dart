import 'package:flutter/material.dart';
import 'package:uni_app/onboarding/onboarding.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Onboarding()),
    );
  }
}
