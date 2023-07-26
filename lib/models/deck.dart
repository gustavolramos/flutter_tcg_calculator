import 'card.dart';

class Deck {
  Deck({required name, required size, required cardList});

  late String name;
  late int size;
  late List<Card> cardList;

  void drawCards(Deck deck, bool goingFirst) {
    // Receives a deck and returns a list of cards, the drawn cards
    // Needs to perform a shuffle operation, perhaps these could be two separate modules
  }

  void calculateChancesPerTag(Deck deck, String tag) {
// Receives a deck and a certain tag, checks the amount of cards with a given tag
// Returns a % of chance of seeing at least one copy with the given tag
  }

  void calculateChancesPerName(Deck deck, String name) {
    // Receibes a deck and a certain tag, checks the deck looking for a card with that name
    // If it finds at least 1, it checks how many copies it has in the deck, otherwise returns a message: "card not found"
    // After finding the quantity, it calculates the chance of opening with at least one copy
  }
}