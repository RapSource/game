import 'package:flutter/foundation.dart';
import 'package:gameku/model/data/db/database_helper.dart';
import 'package:gameku/model/data/favorite.dart';
import 'package:gameku/model/data/game_detail.dart';
import 'package:gameku/provider/result_state.dart';

class DatabaseProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<GameDetail> _favorite = [];
  List<GameDetail> get favorite => _favorite;

  void _getFavorites() async {
    _favorite = (await databaseHelper.getFavorite()).cast<GameDetail>();
    if (_favorite.length > 0) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(GameDetail game) async {
    try {
      await databaseHelper.insertFavorite(Favorite(
        id: game.id,
        name: game.name,
        backgroundImage: game.backgroundImage,
        genres: game.getGenre(),
        rating: game.rating)
      );
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(int id) async {
    final favoriteGame = await databaseHelper.getFavoriteById(id);
    return favoriteGame.isNotEmpty;
  }

  void removeFavorite(int id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}