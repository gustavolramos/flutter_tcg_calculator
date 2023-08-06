import 'card_model.dart';

class DeckModel {
  DeckModel({this.id, required this.name, required this.cardList});

  String? id;
  late String name;
  late List<CardModel?> cardList;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cardList': cardList.map((card) => card?.toMap()).toList(),
    };
  }

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    return DeckModel(
      id: json['id'],
      name: json['name'] as String,
      cardList: (json['cardList']!)
          .map((cardSnapshot) =>
              CardModel.fromJson(cardSnapshot as Map<String, dynamic>))
          .toList(),
    );
  }
}