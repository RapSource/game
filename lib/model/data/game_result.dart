import 'dart:convert';

// To parse this JSON data, do
//
//     final gameResult = gameResultFromJson(jsonString);

GameResult gameResultFromJson(String str) => GameResult.fromJson(json.decode(str));

String gameResultToJson(GameResult data) => json.encode(data.toJson());

class GameResult {
    int count;
    String next;
    dynamic previous;
    List<Result> results;

    GameResult({
        required this.count,
        required this.next,
        this.previous,
        required this.results,
    });

    factory GameResult.fromJson(Map<String, dynamic> json) => GameResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    int id;
    String name;
    String backgroundImage;
    double rating;
    List<Genre> genres;

    Result({
        required this.id,
        required this.name,
        required this.backgroundImage,
        required this.rating,
        required this.genres,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        backgroundImage: json["background_image"],
        rating: json["rating"]?.toDouble(),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "background_image": backgroundImage,
        "rating": rating,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

class Genre {
    int id;
    String name;
    String slug;
    int gamesCount;
    String imageBackground;

    Genre({
        required this.id,
        required this.name,
        required this.slug,
        required this.gamesCount,
        required this.imageBackground,
    });

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        gamesCount: json["games_count"],
        imageBackground: json["image_background"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "games_count": gamesCount,
        "image_background": imageBackground,
    };
}

