import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/card_model.dart';
import '../models/deck_model.dart';

class CustomDeckService {
  Future<void> addDeck(DeckModel deck) async {
    try {
      await FirebaseFirestore.instance.collection('decks').add(deck.toJson());
    } catch (e) {
      print('Error adding deck: $e');
    }
  }

  Future<DeckModel?> getDeck(String deckId) async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection('decks')
          .doc(deckId)
          .get();
      if (doc.exists) {
        return DeckModel.fromJson(doc as Map<String, dynamic>);
      } else {
        // ignore: avoid_print
        print('DeckModel not found!');
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error getting deck: $e');
      return null;
    }
  }

  Future<void> editDeck(String deckId, DeckModel updatedDeck) async {
    try {
      Map<String, dynamic> deckMap = updatedDeck.toJson();
      await FirebaseFirestore.instance
          .collection('Decks')
          .doc(deckId)
          .update(deckMap);
      // ignore: avoid_print
      print('DeckModel edited successfully! Here is the $deckMap');
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
      print('DeckModel could not be deleted, the found error is $e');
    }
  }

  Future<void> addListOfCardsToDeck(String deckId, List<CardModel> cards) async {
    final deckRef = FirebaseFirestore.instance.collection('decks').doc(deckId);
    final doc = await deckRef.get();
    if (doc.exists) {
      final deckData = doc.data() as Map<String, dynamic>;
      if (deckData.containsKey('cardList')) {
        final List<dynamic> existingCards = deckData['cardList'];
        final List<Map<String, dynamic>> newCards = cards.map((card) => card.toMap()).toList();
        existingCards.addAll(newCards);
        deckData['cardList'] = existingCards;
      } else {
        deckData['cardList'] = cards.map((card) => card.toMap()).toList();
      }
      await deckRef.update(deckData);
    }
  }

  Future<List<CardModel>> getCardsInDeck(String deckId) async {
    try {
      final deckRef = FirebaseFirestore.instance.collection('decks').doc(deckId);

      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;

        // If the 'cardList' field exists, convert it to a list of CardModel objects
        if (deckData.containsKey('cardList')) {
          final List<dynamic> cardListData = deckData['cardList'];
          final List<CardModel> cardList =
              cardListData.map((cardData) => CardModel.fromJson(cardData as Map<String, dynamic>)).toList();
          return cardList;
        }
      }
    } catch (e) {
      print('Error getting list of cards from deck: $e');
    }
    return [];
  }
}