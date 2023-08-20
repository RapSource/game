import 'package:flutter/foundation.dart';
import 'package:gameku/provider/result_state.dart';

import '../data/api/api_service.dart';
import '../data/model/screenshot.dart';

class ScreenShotProvider extends ChangeNotifier {
  final ApiService apiService;

  ScreenShotProvider({required this.apiService});

  bool isFetch = false;
  late ShortScreensShot _screenShot;
  late ResultState _state;

  ShortScreensShot get screenShot => _screenShot;
  ResultState get state => _state;

  Future<dynamic> screenShotGame(int id) async {
    _state = ResultState.loading;
    notifyListeners();
    try {
     final ss = await apiService.getScreenShot(id);
    _screenShot = ss;
    _state = ResultState.hasData;
    isFetch = true;
    notifyListeners(); 
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }

    return _screenShot;
  }

}
