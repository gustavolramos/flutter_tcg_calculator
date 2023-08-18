import 'package:flutter/material.dart';
import 'package:flutter_tcg_calculator/view/widgets/app_bar.dart';

class CustomLoadingPage extends StatelessWidget {
  const CustomLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 150),
      body: SizedBox(
        height: 200,
        width: 200,
        child: RotationTransition(
      turns: const AlwaysStoppedAnimation(0.25), 
      child: Image.asset('assets/images/yu-gi-oh-logo.jpg'), 
    ),
      )
    );
  }
}