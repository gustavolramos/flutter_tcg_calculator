import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/deck_controller.dart';
import '../models/card_model.dart';
import '../services/deck_services.dart';

final deckServiceProvider = Provider.autoDispose<CustomDeckService>((ref) => CustomDeckService());
final deckControllerProvider = Provider.autoDispose<CustomDeckController>((ref) {
  final service = ref.read(deckServiceProvider);
  return CustomDeckController(service);
});


final cardListInDeckProvider = FutureProvider.family<List<CardModel>, String>((ref, deckId) {
  final deckController = ref.read(deckControllerProvider);
  return deckController.getCardListInDeck(deckId);
});