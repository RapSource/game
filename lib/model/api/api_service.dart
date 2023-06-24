import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/game_detail.dart';
import '../data/game_result.dart';
import '../data/screenshot.dart';
import '../data/video_thumbnail.dart';

class ApiService {
  int? id;

  Future<GameResult> getGameResult() async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/games?results&key=05e574a9d3fb4906b0b832baf05b086d'));
    var jsonObject = json.decode(apiResult.body);

    return GameResult.fromJson(jsonObject);
  }

    Future<GameDetail> getGameDetail(id) async {
    var apiDetail = await http.get(Uri.parse(
        'https://api.rawg.io/api/games/${id}?key=05e574a9d3fb4906b0b832baf05b086d'));
    var jsonObject = json.decode(apiDetail.body);

    return GameDetail.fromJson(jsonObject);
  }

  Future<ThumbnailVideo> getThumbnailVideo(id) async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/games/${id}/movies?key=05e574a9d3fb4906b0b832baf05b086d'));
    var jsonObject = json.decode(apiResult.body);

    return ThumbnailVideo.fromJson(jsonObject);
  }

  Future<ShortScreensShot> getScreenShot(id) async {
    var apiResult = await http.get(Uri.parse(
        'https://api.rawg.io/api/games/${id}/screenshots?key=05e574a9d3fb4906b0b832baf05b086d'));
    var jsonObject = json.decode(apiResult.body);

    return ShortScreensShot.fromJson(jsonObject);
  }
}
