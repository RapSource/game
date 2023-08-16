import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/game_detail.dart';
import '../data/game_developers.dart';
import '../data/game_publishers.dart';
import '../data/game_result.dart';
import '../data/screenshot.dart';
import '../data/video_thumbnail.dart';

class ApiService {

  Future<GameResult> getGameResult() async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/games?results&key=f42fedf990ec402cbce31651c741ba35'));
    var jsonObject = json.decode(apiResult.body);

    return GameResult.fromJson(jsonObject);
  }

    Future<GameDetail> getGameDetail(int id) async {
    var apiDetail = await http.get(Uri.parse(
        'https://api.rawg.io/api/games/$id?key=f42fedf990ec402cbce31651c741ba35'));
    var jsonObject = json.decode(apiDetail.body);

    return GameDetail.fromJson(jsonObject);
  }

  Future<ThumbnailVideo> getThumbnailVideo(int id) async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/games/$id/movies?key=f42fedf990ec402cbce31651c741ba35'));
    var jsonObject = json.decode(apiResult.body);

    return ThumbnailVideo.fromJson(jsonObject);
  }

  Future<ShortScreensShot> getScreenShot(int id) async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/games/$id/screenshots?key=f42fedf990ec402cbce31651c741ba35'));
    var jsonObject = json.decode(apiResult.body);

    return ShortScreensShot.fromJson(jsonObject);
  }

  Future<GameDeveloper> getGameDeveloper(int id) async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/developers/$id?key=f42fedf990ec402cbce31651c741ba35'));
    var jsonObject = json.decode(apiResult.body);

    return GameDeveloper.fromJson(jsonObject);
  }

  Future<GamePublisher> getGamePublisher(int id) async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/publishers/$id?key=f42fedf990ec402cbce31651c741ba35'));
    var jsonObject = json.decode(apiResult.body);

    return GamePublisher.fromJson(jsonObject);
  }
}
