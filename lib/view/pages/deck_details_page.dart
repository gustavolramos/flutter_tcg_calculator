import 'package:flutter/material.dart';
import 'package:flutter_tcg_calculator/view/widgets/app_bar.dart';

class DeckDetailsPage extends StatelessWidget {
  const DeckDetailsPage({super.key, required this.docId});

  final String? docId;

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: CustomAppBar(height: 150),
      body: Column(
        children: [
          Text('deck name'),
          // FirestoreListView goes here
        ],
      ),
    );
  }
}