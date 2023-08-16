import 'package:flutter/cupertino.dart';
import 'package:gameku/provider/result_state.dart';

import '../model/api/api_service.dart';
import '../model/data/game_developers.dart';

class GameDevelopersProvider extends ChangeNotifier {
  final ApiService apiService;

  GameDevelopersProvider({required this.apiService}) {
    _fetchDeveloper;
  }

  GameDeveloper? _developerGames;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  GameDeveloper? get result => _developerGames;
  ResultState get state => _state;

  Future<dynamic> _fetchDeveloper(int id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final developer = await apiService.getGameDeveloper(id);
      if (developer.results.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _developerGames = developer;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
