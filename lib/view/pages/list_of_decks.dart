import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import '../../models/deck_model.dart';
import '../../utils/firebase_queries.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<DeckModel>(
        query: decksQuery,
        pageSize: 20,
        emptyBuilder: (context) => const Text('No data'),
        errorBuilder: (context, error, stackTrace) => Text(error.toString()),
        loadingBuilder: (context) => const CircularProgressIndicator(),
        itemBuilder: (context, snapshot) {
          DeckModel deck = snapshot.data();
          return ListTile(
            title: Text(deck.name),
            subtitle: const Text('my Deck'),
          );
        });
  }
}