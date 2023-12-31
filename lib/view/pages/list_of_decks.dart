// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter_tcg_calculator/view/pages/loading_page.dart';
import 'package:flutter_tcg_calculator/view/widgets/app_bar.dart';
import 'package:flutter_tcg_calculator/view/widgets/deck_list_tile.dart';
import '../../controllers/deck_controller.dart';
import '../../models/deck_model.dart';
import '../widgets/floating_action_button.dart';

class ListOfDecks extends StatelessWidget {
  const ListOfDecks
({required this.decksQuery, required this.deckController, super.key});

  final Query<DeckModel> decksQuery;
  final CustomDeckController deckController;

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
            DeckModel deck = snapshot.data(); // Need to find a way to assure this deck is instantiated with the ID
            print('Deck ID: ${deck.id} and ${deck.name}'); // Trying to understand where I'm missing the ID
            return Material(
                child: DeckListTile(
              name: deck.name,
              deckId: deck.id,
            ));
          }),
      floatingActionButton: AddDeckFloatingActionButton(deckController: deckController),
    );
  }
}