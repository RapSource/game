import 'package:flutter/cupertino.dart';
import 'package:gameku/provider/result_state.dart';

import '../model/api/api_service.dart';
import '../model/data/game_publishers.dart';

class GamePublishersProvider extends ChangeNotifier {
  final ApiService apiService;

  GamePublishersProvider({required this.apiService}) {
    _fetchPublisher;
  }

  late GamePublisher? _publisherGames;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  GamePublisher? get result => _publisherGames;
  ResultState get state => _state;

  Future<dynamic> _fetchPublisher(int id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final publisher = await apiService.getGamePublisher(id);
      if (publisher.results.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _publisherGames = publisher;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
