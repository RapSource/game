import 'package:flutter/cupertino.dart';
import 'package:gameku/provider/result_state.dart';

import '../data/api/api_service.dart';
import '../data/model/game_detail.dart';
import '../data/model/developers_publishers.dart';

class GameDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  GameDetailProvider({required this.apiService});
  
  late ResultState _state;
  
  late GameDetail _gameDetail;
  late DeveloperPublisher _developer;
  late DeveloperPublisher _publisher;

  GameDetail get gameDetail => _gameDetail;
  DeveloperPublisher get developer => _developer;
  DeveloperPublisher get publisher => _publisher;
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

  Future<dynamic> getDeveloper(int id) async {
    _state = ResultState.loading;
    notifyListeners();
    try {
     final developer = await apiService.getDeveloper(id);
    _developer = developer;
    _state = ResultState.hasData;
    notifyListeners(); 
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }

    return _developer;
  }

  Future<dynamic> getPublisher(int id) async {
    _state = ResultState.loading;
    notifyListeners();
    try {
     final publisher = await apiService.getPublisher(id);
    _publisher = publisher;
    _state = ResultState.hasData;
    notifyListeners(); 
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }

    return _publisher;
  }
}
