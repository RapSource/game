import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/game_detail.dart';
import '../model/developers_publishers.dart';
import '../model/game_result.dart';
import '../model/screenshot.dart';
import '../model/video_thumbnail.dart';

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

  Future<DeveloperPublisher> getDeveloper(int id) async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/developers/$id?key=f42fedf990ec402cbce31651c741ba35'));
    var jsonObject = json.decode(apiResult.body);

    return DeveloperPublisher.fromJson(jsonObject);
  }

  Future<DeveloperPublisher> getPublisher(int id) async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/publishers/$id?key=f42fedf990ec402cbce31651c741ba35'));
    var jsonObject = json.decode(apiResult.body);

    return DeveloperPublisher.fromJson(jsonObject);
  }

  Future<GameResult> getSearchGame(String query) async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/games?search=$query&key=f42fedf990ec402cbce31651c741ba35'));
    var jsonObject = json.decode(apiResult.body);

    return GameResult.fromJson(jsonObject);
  }
}
