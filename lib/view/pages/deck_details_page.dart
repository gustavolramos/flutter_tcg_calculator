import 'package:flutter/material.dart';
import 'package:flutter_tcg_calculator/controllers/deck_controller.dart';
import 'package:flutter_tcg_calculator/view/widgets/app_bar.dart';
import 'package:flutter_tcg_calculator/view/widgets/card_list_tile.dart';
import '../../models/card_model.dart';

class DeckDetailsPage extends StatefulWidget {
  const DeckDetailsPage({super.key, required this.deckId});

  final String? deckId;

  @override
  State<DeckDetailsPage> createState() => _DeckDetailsPageState();
}

class _DeckDetailsPageState extends State<DeckDetailsPage> {
  CustomDeckController deckController = CustomDeckController();
  late Future<List<CardModel>> cardList;

  @override
  void initState() {
    super.initState();
    cardList = deckController.getCardListInDeck(widget.deckId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 150),
      body: FutureBuilder<List<CardModel>>(
        future: cardList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data available.');
          } else {
            List<CardModel> cardListData = snapshot.data!;
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
    );
  }
}