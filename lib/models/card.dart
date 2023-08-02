import '../utils/enums.dart';

class CustomCard {
  CustomCard(
      {required this.name,
      required this.type,
      required this.attribute,
      required this.quantity,
      required this.tag});

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

  CustomCard.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
          type: _cardTypeFromString(json['type']),
          attribute: _attributeFromString(json['attribute']),
          tag: _tagFromString(json['tag']),
          quantity: json['quantity'],
        );

  static CardType _cardTypeFromString(String type) =>
      CardType.values.firstWhere((e) => e.toString() == type);

  static Attribute _attributeFromString(String attribute) =>
      Attribute.values.firstWhere((e) => e.toString() == attribute);

  static Tag _tagFromString(String tag) =>
      Tag.values.firstWhere((e) => e.toString() == tag);
}