class ShortScreensShot {
    List<ResultScreenShot> results;

    ShortScreensShot({
        required this.results,
    });

    factory ShortScreensShot.fromJson(Map<String, dynamic> json) => ShortScreensShot(
        results: List<ResultScreenShot>.from(json["results"].map((x) => ResultScreenShot.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class ResultScreenShot {
    int id;
    String image;
    int width;
    int height;
    bool isDeleted;

    ResultScreenShot({
        required this.id,
        required this.image,
        required this.width,
        required this.height,
        required this.isDeleted,
    });

    factory ResultScreenShot.fromJson(Map<String, dynamic> json) => ResultScreenShot(
        id: json["id"],
        image: json["image"],
        width: json["width"],
        height: json["height"],
        isDeleted: json["is_deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "width": width,
        "height": height,
        "is_deleted": isDeleted,
    };
}
