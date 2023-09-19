import 'package:flutter/material.dart';

class CustomLoadingPage extends StatelessWidget {
  const CustomLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: RotationTransition(
        turns: const AlwaysStoppedAnimation(0.10), 
        child: Image.asset('assets/images/yu-gi-oh-logo.jpg'), 
          ),
        ),
      )
    );
  }
}