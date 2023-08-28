import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 50),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/decklist'), 
          child: const Text('Go to List of Decks')),
      ),
    );
  }
}