import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: CardListScreen(),
        ),
      ),
    );
  }
}

class CardListScreen extends StatelessWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card List'),
      ),
      body: const CardList(),
    );
  }
}

class CardList extends StatelessWidget {
  const CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('decks').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final deckDocument = snapshot.data!.docs.first;
        final deckData = deckDocument.data() as Map<String, dynamic>;

        final cardList = (deckData['cardList'] as List<dynamic>)
            .map((cardData) => CustomCard.fromSnapshot(cardData))
            .toList();

        return ListView.builder(
          itemCount: cardList.length,
          itemBuilder: (context, index) {
            final card = cardList[index];
            return ListTile(
              title: Text(card.name),
              subtitle: Text(card.type.toString()),
            );
          },
        );
      },
    );
  }
}