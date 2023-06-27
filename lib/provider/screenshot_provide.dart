import 'package:flutter/foundation.dart';

import '../model/api/api_service.dart';
import '../model/data/screenshot.dart';

class ScreenShotProvider extends ChangeNotifier {
  final ApiService apiService;

  ScreenShotProvider({required this.apiService});

  late ShortScreensShot _screenShot;
  ShortScreensShot get screenShot => _screenShot;

  Future<dynamic> screenShotGame(id) async {
    final ss = await apiService.getScreenShot(id);
    _screenShot = ss;
    notifyListeners();

    return _screenShot;
  }

}
