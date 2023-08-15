import '../utils/enums.dart';

class CardModel {
  CardModel({
    this.id,
    required this.name,
    required this.type,
    required this.attribute,
    required this.quantity,
    required this.tag,
  });

  String? id;
  late String name;
  late CardType type;
  late Attribute attribute;
  late Tag tag;
  late int quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.toString(),
      'attribute': attribute.toString(),
      'tag': tag.toString(),
      'quantity': quantity,
    };
  }

  CardModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name']!,
          type: _cardTypeFromString(json['type']!),
          attribute: _attributeFromString(json['attribute']!),
          tag: _tagFromString(json['tag']!),
          quantity: json['quantity']!,
        );

  static CardType _cardTypeFromString(String type) =>
      CardType.values.firstWhere((e) => e.toString() == type);

  static Attribute _attributeFromString(String attribute) =>
      Attribute.values.firstWhere((e) => e.toString() == attribute);

  static Tag _tagFromString(String tag) =>
      Tag.values.firstWhere((e) => e.toString() == tag);
}
