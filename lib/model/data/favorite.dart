class Favorite {
  int id;
  String name;
  String backgroundImage;

  Favorite({
    required this.id,
    required this.name,
    required this.backgroundImage,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    name: json["name"],
    backgroundImage: json["background_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "background_image": backgroundImage,
  };

}