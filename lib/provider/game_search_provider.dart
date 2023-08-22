import 'package:flutter/material.dart';
import 'package:gameku/provider/result_state.dart';

import '../data/api/api_service.dart';
import '../data/model/game_result.dart';

class SearchGameProvider extends ChangeNotifier{
  final ApiService apiService;

  SearchGameProvider({required this.apiService});

  late GameResult _resultSearch;
  GameResult get resultSearch => _resultSearch;

  ResultState _state = ResultState.noData;
  ResultState get state => _state;
  
  String _message = '';
  String get message => _message;

  Future<dynamic> fetchSearchGame(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final search = await apiService.getSearchGame(query);
      if (search.results.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _resultSearch = search;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }
}