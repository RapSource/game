import 'package:flutter/cupertino.dart';
import 'package:gameku/provider/result_state.dart';

import '../model/api/api_service.dart';
import '../model/data/game_detail.dart';

class GameDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  GameDetailProvider({required this.apiService});

  late GameDetail _gameDetail;
  late ResultState _state;

  GameDetail get gameDetail => _gameDetail;
  ResultState get state => _state;

  Future<dynamic> fetchDetailGame(int id) async {
    _state = ResultState.loading;
    notifyListeners();
    try {
     final detailGame = await apiService.getGameDetail(id);
    _gameDetail = detailGame;
    _state = ResultState.hasData;
    notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }

    return _gameDetail;
  }
}
