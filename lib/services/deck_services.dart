// ignore_for_file: avoid_print
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
        print('DeckModel not found!');
        return null;
      }
    } catch (e) {
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
      print('DeckModel edited successfully! Here is the $deckMap');
    } catch (e) {
      print('Error editing deck: $e');
    }
  }

  Future<void> deleteDeck(String deckId) async {
    try {
      await FirebaseFirestore.instance.collection('Decks').doc(deckId).delete();
    } catch (e) {
      print('DeckModel could not be deleted, the found error is $e');
    }
  }

  Future<void> addListOfCardsToDeck(
      String deckId, List<CardModel> cards) async {
    try {
      final deckRef =
          FirebaseFirestore.instance.collection('decks').doc(deckId);
      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;
        if (deckData.containsKey('cardList')) {
          final List<dynamic> existingCards = deckData['cardList'];
          final List<Map<String, dynamic>> newCards =
              cards.map((card) => card.toMap()).toList();
          existingCards.addAll(newCards);
          deckData['cardList'] = existingCards;
        } else {
          deckData['cardList'] = cards.map((card) => card.toMap()).toList();
        }
        await deckRef.update(deckData);
      }
    } catch (e) {
      print('Error adding cards to deck: $e');
    }
  }

  Future<void> addCardToDeck(String deckId, CardModel card) async {
    try {
      final deckRef =
          FirebaseFirestore.instance.collection('decks').doc(deckId);
      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;
        if (deckData.containsKey('cardList')) {
          final List<dynamic> existingCards = deckData['cardList'];
          existingCards.add(card.toMap());
          deckData['cardList'] = existingCards;
        } else {
          deckData['cardList'] = [card.toMap()];
        }
        await deckRef.update(deckData);
      }
    } catch (e) {
      print('Error adding card to deck: $e');
    }
  }

  Future<List<CardModel>> getCardListInDeck(String deckId) async {
    try {
      final deckRef =
          FirebaseFirestore.instance.collection('decks').doc(deckId);

      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;
        if (deckData.containsKey('cardList')) {
          final List<dynamic> cardListData = deckData['cardList'];
          final List<CardModel> cardList = cardListData
              .map((cardData) =>
                  CardModel.fromJson(cardData as Map<String, dynamic>))
              .toList();
          return cardList;
        }
      }
    } catch (e) {
      print('Error getting list of cards from deck: $e');
    }
    return [];
  }

  Future<CardModel?> getSingleCardInDeck(String deckId, String cardId) async {
    try {
      final deckRef =
          FirebaseFirestore.instance.collection('decks').doc(deckId);

      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;

        // If the 'cardList' field exists, find the card with the specified ID
        if (deckData.containsKey('cardList')) {
          final List<dynamic> cardListData = deckData['cardList'];
          final cardData = cardListData.firstWhere(
              (cardData) => cardData['id'] == cardId,
              orElse: () => null);
          if (cardData != null) {
            return CardModel.fromJson(cardData as Map<String, dynamic>);
          }
        }
      }
    } catch (e) {
      print('Error getting card from deck: $e');
    }
    return null;
  }

  Future<void> editCardInDeck(String deckId, CardModel updatedCard) async {
    try {
      final deckRef =
          FirebaseFirestore.instance.collection('decks').doc(deckId);

      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;

        // If the 'cardList' field exists, find and update the card with the specified ID
        if (deckData.containsKey('cardList')) {
          final List<dynamic> cardListData = deckData['cardList'];
          final int index = cardListData
              .indexWhere((cardData) => cardData['id'] == updatedCard.id);
          if (index != -1) {
            cardListData[index] = updatedCard.toMap();
            deckData['cardList'] = cardListData;
          }
        }

        // Update the deck with the modified card list
        await deckRef.update(deckData);
      }
    } catch (e) {
      print('Error editing card in deck: $e');
    }
  }

  Future<void> deleteCardFromDeck(String deckId, String cardId) async {
    try {
      final deckRef = FirebaseFirestore.instance.collection('decks').doc(deckId);
      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;
        if (deckData.containsKey('cardList')) {
          final List<dynamic> cardListData = deckData['cardList'];
          final updatedCardListData = cardListData
              .where((cardData) => cardData['id'] != cardId)
              .toList();
          deckData['cardList'] = updatedCardListData;
        }
        await deckRef.update(deckData);
      }
    } catch (e) {
      print('Error deleting card from deck: $e');
    }
  }
}