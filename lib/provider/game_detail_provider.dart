import 'package:flutter/cupertino.dart';

import '../model/api/api_service.dart';
import '../model/data/game_detail.dart';

class GameDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  GameDetailProvider({required this.apiService});

  late GameDetail _gameDetail;
  GameDetail get gameDetail => _gameDetail;

  Future<dynamic> fetchDetailGame(id) async {
    final detailGame = await apiService.getGameDetail(id);
    _gameDetail = detailGame;
    notifyListeners();

    return _gameDetail;
  }
}
