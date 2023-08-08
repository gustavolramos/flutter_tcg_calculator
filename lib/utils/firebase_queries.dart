import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/deck_model.dart';

final Query<DeckModel> decksQuery = FirebaseFirestore.instance
    .collection('decks')
    .orderBy('name')
    .withConverter(
      fromFirestore: (snapshot, _) => DeckModel.fromJson(snapshot.data()!),
      toFirestore: (deck, _) => deck.toJson(),
    );