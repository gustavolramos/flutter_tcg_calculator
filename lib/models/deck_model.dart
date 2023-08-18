class DeckModel {
  DeckModel({
    required this.name,
    required this.cardList,
  });

  String? id;
  late String name;
  List<Map<String, dynamic>> cardList;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cardList': cardList,
    };
  }

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    return DeckModel(
        name: json['name'] as String,
        cardList: (json['cardList'] as List<dynamic>).cast<Map<String, dynamic>>());
  }
}