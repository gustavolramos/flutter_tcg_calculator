import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/card_model.dart';
import '../models/deck_model.dart';
import '../services/deck_services.dart';

class CustomDeckController {
  CustomDeckController(this._deckService);

  final CustomDeckService _deckService;

  Query<DeckModel> get decksQuery => _deckService.decksQuery;

  Future<List<DeckModel>> getAllDecks() async {
    return await _deckService.getAllDecks();
  }

  Future<DeckModel?> getDeck(String deckId) async {
    return await _deckService.getDeck(deckId);
  }

  Future<void> addDeck(DeckModel deck) async {
    await _deckService.addDeck(deck);
  }

  Future<void> editDeck(String deckId, DeckModel updatedDeck) async {
    await _deckService.editDeck(deckId, updatedDeck);
  }

  Future<void> deleteDeck(String deckId) async {
    await _deckService.deleteDeck(deckId);
  }

  Future<List<CardModel>> getCardListInDeck(String? deckId) async {
    return await _deckService.getCardListInDeck(deckId);
  }

  Future<CardModel?> getCardInDeck(String deckId, String cardId) async {
    return await _deckService.getSingleCardInDeck(deckId, cardId);
  }

  Future<void> addListOfCardsToDeck(
      String deckId, List<CardModel> cards) async {
    await _deckService.addListOfCardsToDeck(deckId, cards);
  }

  Future<void> addCardToDeck(String deckId, CardModel card) async {
    await _deckService.addCardToDeck(deckId, card);
  }

  Future<void> editCardInDeck(String deckId, CardModel updatedCard) async {
    await _deckService.editCardInDeck(deckId, updatedCard);
  }

  Future<void> deleteCardFromDeck(String deckId, String cardId) async {
    await _deckService.deleteCardFromDeck(deckId, cardId);
  }

double calculateBinomialCoefficient(int totalItems, int selectedItems) {
  if (selectedItems == 0 || selectedItems == totalItems) {
    return 1;
  }
  double result = 1;
  for (int i = 1; i <= selectedItems; i++) {
    result = result * (totalItems - selectedItems + i) / i;
  }
  return result;
}

  double calculateHypergeometricProbability(
    int totalCardsInDeck,
    int numOfGivenCard,
    int numberOfCardsInOpeningHand,
  ) {
    double probabilityNoCopies = calculateBinomialCoefficient(totalCardsInDeck - numOfGivenCard, numberOfCardsInOpeningHand) / calculateBinomialCoefficient(totalCardsInDeck, numberOfCardsInOpeningHand);
    return (1 - probabilityNoCopies) * 100;
  }
}