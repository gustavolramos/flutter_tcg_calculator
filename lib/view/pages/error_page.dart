import 'package:flutter/material.dart';
import 'package:flutter_tcg_calculator/view/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';

class CustomErrorPage extends StatelessWidget {
  const CustomErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 50),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'), 
          child: const Text('Return to Home Page')),
      ),
    );
  }
}