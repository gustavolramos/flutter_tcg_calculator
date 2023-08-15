import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/deck_controller.dart';
import '../models/card_model.dart';

// I'll trasition all the FutureBuilder implementations to a provider approach later

final deckIdProvider = Provider((ref){});

final cardListProvider = FutureProvider<List<CardModel>>((ref) async {
  final deckId = ref.read(deckIdProvider); 
  final deckController = CustomDeckController();
  return deckController.getCardListInDeck(deckId);
});