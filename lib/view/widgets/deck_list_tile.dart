import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/deck_providers.dart';
import '../../utils/dialog_utils.dart';

class DeckListTile extends ConsumerWidget {
  const DeckListTile({
    required this.name,
    required this.deckId,
    Key? key,
  }) : super(key: key);

  final String name;
  final String? deckId;

  void _editDeck(BuildContext context, WidgetRef ref) {
    DialogUtils.showEditDialog(context, (newName) async {
      final customDeckController = ref.read(deckControllerProvider);
      final updatedDeck = await customDeckController.getDeck(deckId!);

      if (updatedDeck != null) {
        updatedDeck.name = newName;
        await customDeckController.editDeck(deckId!, newName: updatedDeck.name);
      }
    });
  }

  void _deleteDeck(BuildContext context, WidgetRef ref) {
    DialogUtils.showDeleteDialog(context, () async {
      final customDeckController = ref.read(deckControllerProvider);
      await customDeckController.deleteDeck(deckId!);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.person_2_rounded),
      title: Title(color: Colors.purple, child: Text(name)),
      onTap: () => context.go("/decklist/$deckId"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editDeck(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteDeck(context, ref),
          ),
        ],
      ),
    );
  }
}
