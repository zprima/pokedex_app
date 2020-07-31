class Pokemon {
  final int id;
  final String num;
  final String name;
  final String img;
  final List<String> type;

  Pokemon({this.id, this.num, this.name, this.img, this.type});

  factory Pokemon.fromJson(dynamic json) {
    return Pokemon(
        id: json["id"],
        num: json["num"],
        name: json["name"],
        img: json["img"],
        type: List<String>.from(json["type"]));
  }
}