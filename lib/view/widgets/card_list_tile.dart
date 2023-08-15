import 'package:flutter/material.dart';

class CardListTile extends StatelessWidget {
  const CardListTile({required this.name, required this.quantity, super.key});

  final String name;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person_2_rounded),
      title: Title(color: Colors.purple, child: Text(name)),
      subtitle: Text(quantity.toString()),
    );
  }
}