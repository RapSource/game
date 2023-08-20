import 'package:flutter/material.dart';
import 'package:gameku/provider/result_state.dart';

import '../data/api/api_service.dart';
import '../data/model/game_result.dart';

class SearchGameProvider extends ChangeNotifier{
  final ApiService apiService;

  SearchGameProvider({required this.apiService});

  late GameResult _searchGame;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  GameResult get resultSearch => _searchGame;
  ResultState get state => _state;

  Future<dynamic> fetchSearchGame(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final search = await apiService.getSearchGame(query);
      if (search.results.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchGame = search;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}