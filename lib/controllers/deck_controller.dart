import '../models/card_model.dart';
import '../models/deck_model.dart';
import '../services/deck_services.dart';

class CustomDeckController {
  final CustomDeckService _deckService = CustomDeckService();

  Future<void> addDeck(DeckModel deck) async {
    await _deckService.addDeck(deck);
  }

  Future<DeckModel?> getDeck(String deckId) async {
    return await _deckService.getDeck(deckId);
  }

  Future<void> editDeck(String deckId, DeckModel updatedDeck) async {
    await _deckService.editDeck(deckId, updatedDeck);
  }

  Future<void> deleteDeck(String deckId) async {
    await _deckService.deleteDeck(deckId);
  }

  Future<void> addListOfCardsToDeck(
      String deckId, List<CardModel> cards) async {
    await _deckService.addListOfCardsToDeck(deckId, cards);
  }

  Future<void> addCardToDeck(String deckId, CardModel card) async {
    await _deckService.addCardToDeck(deckId, card);
  }

  Future<List<CardModel>> getCardListInDeck(String? deckId) async {
    return await _deckService.getCardListInDeck(deckId);
  }

  Future<CardModel?> getCardInDeck(String deckId, String cardId) async {
    return await _deckService.getSingleCardInDeck(deckId, cardId);
  }

  Future<void> editCardInDeck(String deckId, CardModel updatedCard) async {
    await _deckService.editCardInDeck(deckId, updatedCard);
  }

  Future<void> deleteCardFromDeck(String deckId, String cardId) async {
    await _deckService.deleteCardFromDeck(deckId, cardId);
  }

  double choose(int n, int k) {
    if (k == 0 || k == n) {
      return 1;
    }
    double result = 1;
    for (int i = 1; i <= k; i++) {
      result = result * (n - k + i) / i;
    }
    return result;
  }

  double hypergeometricProbability(
    int numOfGivenCard,
    int totalCardsInDeck,
    int numberOfCardsInOpeningHand,
    int numToCheck,
  ) {
    double numerator = 0;
    for (int i = numToCheck; i <= numberOfCardsInOpeningHand; i++) {
      numerator += choose(numOfGivenCard, i) *
          choose(totalCardsInDeck - numOfGivenCard,
              numberOfCardsInOpeningHand - i);
    }
    double denominator = choose(totalCardsInDeck, numberOfCardsInOpeningHand);
    return (numerator / denominator) * 100;
  }
}