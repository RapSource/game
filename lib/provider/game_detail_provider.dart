import 'package:flutter/cupertino.dart';

import '../model/api/api_service.dart';
import '../model/data/game_detail.dart';

class GameDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  GameDetailProvider({required this.apiService});

  late GameDetail _gameDetail;
  String _message = '';

  String get message => _message;
  GameDetail get gameDetail => _gameDetail;

  Future<dynamic> fetchDetailGame(id) async {
    final gameDetail = await apiService.getGameDetail(id);
    _gameDetail = gameDetail;
    notifyListeners();

    return _gameDetail;
  }
}
