import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tcg_calculator/view/pages/loading_page.dart';
import 'package:flutter_tcg_calculator/view/widgets/app_bar.dart';
import 'package:flutter_tcg_calculator/view/widgets/card_list_tile.dart';
import '../../providers/deck_providers.dart';
import 'error_page.dart';

class DeckDetailsPage extends ConsumerWidget {
  const DeckDetailsPage({super.key, required this.deckId});

  final String? deckId;
  
@override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardListAsyncValue = ref.watch(cardListInDeckProvider(deckId!));
    return Scaffold(
      appBar: const CustomAppBar(height: 50),
      body: Material(
        child: cardListAsyncValue.when(
          loading: () => const CustomLoadingPage(),
          error: (error, stackTrace) => const CustomErrorPage(),
          data: (cardListData) {
            if (cardListData.isEmpty) {
              return const Text('No data available.');
            } else {
              return ListView.builder(
                itemCount: cardListData.length,
                itemBuilder: (context, index) {
                  return CardListTile(
                    name: cardListData[index].name,
                    quantity: cardListData.length,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}