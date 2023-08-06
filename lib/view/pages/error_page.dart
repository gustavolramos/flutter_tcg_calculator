import 'package:flutter/material.dart';
import 'package:flutter_tcg_calculator/view/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 150),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'), 
          child: const Text('Return to Home Page')),
      ),
    );
  }
}