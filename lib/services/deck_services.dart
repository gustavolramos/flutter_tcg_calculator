// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/card_model.dart';
import '../models/deck_model.dart';

class CustomDeckService {
  
  final Query<DeckModel> listOfDecksQuery = FirebaseFirestore.instance.collection('decks').orderBy('name').withConverter(
        fromFirestore: (snapshot, _) => DeckModel.fromJson(snapshot.data()!),
        toFirestore: (deck, _) => deck.toJson(),
      );

  Future<List<DeckModel>> getAllDecks() async {
  try {
    final querySnapshot = await listOfDecksQuery.get();
    return querySnapshot.docs.map((doc) {
      final deck = DeckModel.fromJson(doc.data() as Map<String, dynamic>);
      deck.id = doc.id; // Set the 'id' field
      return deck;
    }).toList();
  } catch (e) {
    print('Error getting all decks: $e');
    return [];
  }
}

  Future<DeckModel?> getSingleDeck(String deckId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance.collection('decks').doc(deckId).get();
      if (docSnapshot.exists) {
        final deckData = docSnapshot.data() as Map<String, dynamic>;
        deckData['id'] = docSnapshot.id;
        return DeckModel.fromJson(deckData);
      } else {
        print('Deck not found!');
        return null;
      }
    } catch (e) {
      print('Error getting deck: $e');
      return null;
    }
  }

  Future<void> addDeck(DeckModel deck) async {
    try {
      await FirebaseFirestore.instance.collection('decks').add(deck.toJson());
    } catch (e) {
      print('Error adding deck: $e');
    }
  }

  Future<void> editDeck(String deckId, {String? newName, DeckModel? updatedDeck}) async {
    try {
      if (newName != null) {
        await FirebaseFirestore.instance.collection('decks').doc(deckId).update({'name': newName});
        print('Deck name edited successfully! New name: $newName');
      } else if (updatedDeck != null) {
        final Map<String, dynamic> deckMap = updatedDeck.toJson();
        await FirebaseFirestore.instance.collection('decks').doc(deckId).update(deckMap);
        print('Deck edited successfully! Here is the edited data: $deckMap');
      } else {
        print('No changes provided for editing.');
      }
    } catch (e) {
      print('Error editing deck: $e');
    }
  }

  Future<void> deleteDeck(String deckId) async {
    try {
      await FirebaseFirestore.instance.collection('decks').doc(deckId).delete();
    } catch (e) {
      print('Deck could not be deleted, the found error is $e');
    }
  }

  Future<List<CardModel>> getCardListInDeck(String? deckId) async {
    try {
      final deckRef = FirebaseFirestore.instance.collection('decks').doc(deckId);
      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;
        if (deckData.containsKey('cardList')) {
          final List<dynamic> cardListData = deckData['cardList'];
          final List<CardModel> cardList = cardListData.map((cardData) => CardModel.fromJson(cardData as Map<String, dynamic>)).toList();
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
      final deckRef = FirebaseFirestore.instance.collection('decks').doc(deckId);
      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;
        if (deckData.containsKey('cardList')) {
          final List<dynamic> cardListData = deckData['cardList'];
          final cardData = cardListData.firstWhere((cardData) => cardData['id'] == cardId, orElse: () => null);
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

  Future<void> addListOfCardsToDeck(String deckId, List<CardModel> cards) async {
    try {
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
    } catch (e) {
      print('Error adding cards to deck: $e');
    }
  }

  Future<void> addCardToDeck(String deckId, CardModel card) async {
    try {
      final deckRef = FirebaseFirestore.instance.collection('decks').doc(deckId);
      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;
        final List<dynamic> cardListData = deckData['cardList'] ?? [];
        cardListData.add(card.toMap());
        deckData['cardList'] = cardListData;
        await deckRef.update(deckData);
      }
    } catch (e) {
      print('Error adding card to deck: $e');
    }
  }

  Future<void> editCardInDeck(String deckId, CardModel updatedCard) async {
    try {
      final deckRef = FirebaseFirestore.instance.collection('decks').doc(deckId);
      final doc = await deckRef.get();
      if (doc.exists) {
        final deckData = doc.data() as Map<String, dynamic>;
        final List<dynamic> cardListData = deckData['cardList'] ?? [];
        final int index = cardListData.indexWhere((cardData) => cardData['id'] == updatedCard.id);
        if (index != -1) {
          cardListData[index] = updatedCard.toMap();
          deckData['cardList'] = cardListData;
          await deckRef.update(deckData);
        }
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
        final List<dynamic> cardListData = deckData['cardList'] ?? [];
        final updatedCardListData = cardListData.where((cardData) => cardData['id'] != cardId).toList();
        deckData['cardList'] = updatedCardListData;
        await deckRef.update(deckData);
      }
    } catch (e) {
      print('Error deleting card from deck: $e');
    }
  }
}
