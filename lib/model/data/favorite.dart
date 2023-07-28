class Favorite {
  int id;
  String name;
  String backgroundImage;
  String genres;
  double rating;

  Favorite({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.genres,
    required this.rating
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    name: json["name"],
    backgroundImage: json["background_image"],
    genres: json["genres"],
    rating: json["rating"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "background_image": backgroundImage,
    "genres": genres,
    "rating": rating
  };

}