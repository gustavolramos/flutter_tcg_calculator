import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    final decksQuery = FirebaseFirestore.instance.collection('decks').orderBy('name');

    return FirestoreListView<Map<String, dynamic>>(
        query: decksQuery,
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> deck = snapshot.data();
          return Text('User name is ${deck['name']}');
        });
  }
}