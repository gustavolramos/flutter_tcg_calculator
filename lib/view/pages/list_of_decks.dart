import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter_tcg_calculator/view/pages/loading_page.dart';
import 'package:flutter_tcg_calculator/view/widgets/app_bar.dart';
import 'package:flutter_tcg_calculator/view/widgets/deck_list_tile.dart';
import '../../models/deck_model.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({required this.decksQuery, super.key});

  final Query<DeckModel> decksQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 50),
      body: FirestoreListView<DeckModel>(
          query: decksQuery,
          pageSize: 20,
          emptyBuilder: (context) => const Text('No data'),
          errorBuilder: (context, error, stackTrace) => Text(error.toString()),
          loadingBuilder: (context) => const CustomLoadingPage(),
          itemBuilder: (context, snapshot) {
            DeckModel deck = snapshot.data();
            return Material(
                child: DeckListTile(
              name: deck.name,
              deckId: deck.id,
            ));
          }),
    );
  }
}