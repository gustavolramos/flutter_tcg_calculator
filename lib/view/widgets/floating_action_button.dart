import 'package:flutter/material.dart';
import 'package:flutter_tcg_calculator/controllers/deck_controller.dart';
import '../../models/deck_model.dart';

class AddDeckFloatingActionButton extends StatelessWidget {
  const AddDeckFloatingActionButton({super.key, required this.deckController});

  final CustomDeckController deckController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAddDeckDialog(context);
      },
      child: const Icon(Icons.add),
    );
  }

  void _showAddDeckDialog(BuildContext context) async {
    String? deckName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController deckNameController = TextEditingController();
        return AlertDialog(
          title: const Text('Add New Deck'),
          content: TextField(
            controller: deckNameController,
            decoration: const InputDecoration(labelText: 'Deck Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(deckNameController.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (deckName != null && deckName.isNotEmpty) {
      final newDeck = DeckModel(
        name: deckName,
        cardList: [],
      );
      await deckController.addDeck(newDeck);
    }
  }
}