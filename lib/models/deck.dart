import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'card.dart';

class Deck {
  Deck({required this.name, required this.cardList});

  late String name;
  late List<Card> cardList = [];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cards': cardList.map((card) => card.toMap()).toList(),
    };
  }

  factory Deck.fromSnapshot(DocumentSnapshot snapshot) {
    return Deck(
      name: snapshot['name'],
      cardList: (snapshot['cardList'])
          .map((cardSnapshot) => Card.fromSnapshot(cardSnapshot as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<void> addDeck(Deck deck) async {
    try {
      await FirebaseFirestore.instance.collection('Decks').add(deck.toMap());
    } catch (e) {
      // ignore: avoid_print
      print('Error adding deck: $e');
    }
  }

  Future<Deck?> getDeck(String deckId) async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection('Decks')
          .doc(deckId)
          .get();
      if (doc.exists) {
        return Deck.fromSnapshot(doc);
      } else {
        // ignore: avoid_print
        print('Deck not found!');
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error getting deck: $e');
      return null;
    }
  }

  Future<void> editDeck(String deckId, Deck updatedDeck) async {
    try {
      Map<String, dynamic> deckMap = updatedDeck.toMap();
      await FirebaseFirestore.instance
          .collection('Decks')
          .doc(deckId)
          .update(deckMap);
      // ignore: avoid_print
      print('Deck edited successfully! Here is the $deckMap');
    } catch (e) {
      // ignore: avoid_print
      print('Error editing deck: $e');
    }
  }

  Future<void> deleteDeck(String deckId) async {
    try {
      await FirebaseFirestore.instance.collection('Decks').doc(deckId).delete();
    } catch (e) {
      // ignore: avoid_print
      print('Deck could not be deleted, the found error is $e');
    }
  }

  List<Card> drawCards(int numberOfCardsToDraw) {
    
    if (numberOfCardsToDraw <= 0) {
      // ignore: avoid_print
      print('You cant draw zero or less cards');
      return []; 
    }

    List<Card> drawnCards = [];
    List<Card> availableCards = List.from(cardList);
    availableCards.shuffle();

    for (Card card in availableCards) {
      int availableQuantity = card.quantity - drawnCards.where((c) => c.name == card.name).length;
      int cardsToDraw = min(numberOfCardsToDraw, availableQuantity);
      for (int i = 0; i < cardsToDraw; i++) {
        drawnCards.add(
          Card(
          name: card.name,
          type: card.type,
          attribute: card.attribute,
          tag: card.tag,
          quantity: 1,
        ));
        numberOfCardsToDraw--;
      }
      if (numberOfCardsToDraw == 0) break;
    }
    return drawnCards;
  }

  void calculateChancesPerTag(Deck deck, String tag, int cardsDrawn) {
// Receives a deck, a tag and a number of cards drawn from the deck
// Returns a % of chance of seeing at least one copy of a card that has the given tag
// Number of card drawn cannot be zero or less
// If no card is found it prints this information.
  }

  void calculateChancesPerName(Deck deck, String name) {
// Receives a deck, a tag and a number of cards drawn from the deck
// Returns a % of chance of seeing at least one copy of a card that has the given name
// Number of card drawn cannot be zero or less
  }
}