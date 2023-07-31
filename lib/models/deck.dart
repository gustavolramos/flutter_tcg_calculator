import 'package:cloud_firestore/cloud_firestore.dart';
import 'card.dart';

class Deck {
  Deck({required this.name, required this.cardList});

  late String name;
  late List<CustomCard> cardList;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cardList': cardList.map((card) => card.toMap()).toList(),
    };
  }

  factory Deck.fromSnapshot(DocumentSnapshot snapshot) {
    return Deck(
      name: snapshot['name'],
      cardList: (snapshot['cardList'])
          .map((cardSnapshot) =>
              CustomCard.fromSnapshot(cardSnapshot as Map<String, dynamic>))
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

  // "choose" and "hypergeometricProbability" calculate the % of opening x copies (exactly) of a given card
  // To know the % of drawing "at least x copies" repeat the function with different "numToCheck" up to the number of copies played

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

  double hypergeometricProbability(int numOfGivenCard, int totalCardsInDeck,
      int numberOfCardsInOpeningHand, int numToCheck) {
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
