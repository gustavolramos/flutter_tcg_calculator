import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeckListTile extends StatelessWidget {
  const DeckListTile({
    required this.name,
    required this.deckId,
    super.key,
  });

  final String name;
  final String? deckId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person_2_rounded),
      title: Title(color: Colors.purple, child: Text(name)),
      onTap: () => context.go("/decklist/$deckId"),
    );
  }
}