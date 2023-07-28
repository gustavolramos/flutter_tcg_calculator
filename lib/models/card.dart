import '../utils/enums.dart';

class Card {
  Card({required name, required type, required attribute, required quantity, required tag});

  late String name;
  late CardType type;
  late Attribute attribute;
  late Tag tag;
  late int quantity;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type.toString(),
      'attribute': attribute.toString(),
      'tag': tag.toString(),
      'quantity': quantity,
    };
  }

  factory Card.fromSnapshot(Map<String, dynamic> cardSnapshot) {
    return Card(
      name: cardSnapshot['name'],
      type: _cardTypeFromString(cardSnapshot['type']),
      attribute: _attributeFromString(cardSnapshot['attribute']),
      tag: _tagFromString(cardSnapshot['tag']),
      quantity: cardSnapshot['quantity'],
    );
  }

  static CardType _cardTypeFromString(String type) =>
      CardType.values.firstWhere((e) => e.toString() == type);

  static Attribute _attributeFromString(String attribute) =>
      Attribute.values.firstWhere((e) => e.toString() == attribute);

  static Tag _tagFromString(String tag) =>
      Tag.values.firstWhere((e) => e.toString() == tag);
}