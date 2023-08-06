import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.list),
        title: const Text('TCG Calculator'),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/decklist'), 
          child: const Text('Go to List of Decks')),
      ),
    );
  }
}