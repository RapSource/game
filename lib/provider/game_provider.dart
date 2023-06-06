import 'package:flutter/cupertino.dart';
import 'package:gameku/model/api/api_service.dart';
import 'package:gameku/model/data/game_result.dart';


enum ResultState { loading, noData, hasData, error }

class GameProvider extends ChangeNotifier {
  final ApiService apiService;

  GameProvider({required this.apiService}) {
    _fetchAllGame();
  }

  late GameResult _gamesResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  GameResult get result => _gamesResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllGame() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final game = await apiService.getGameResult();
      if (game.results.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _gamesResult = game;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

}