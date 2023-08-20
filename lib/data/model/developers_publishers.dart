// To parse this JSON data, do
//
//     final developerPublisher = developerPublisherFromJson(jsonString);

class DeveloperPublisher {
    int id;
    String name;
    String slug;
    int gamesCount;
    String imageBackground;
    String description;

    DeveloperPublisher({
        required this.id,
        required this.name,
        required this.slug,
        required this.gamesCount,
        required this.imageBackground,
        required this.description,
    });

    factory DeveloperPublisher.fromJson(Map<String, dynamic> json) => DeveloperPublisher(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        gamesCount: json["games_count"],
        imageBackground: json["image_background"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "games_count": gamesCount,
        "image_background": imageBackground,
        "description": description,
    };
}
