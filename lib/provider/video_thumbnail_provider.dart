import 'package:flutter/foundation.dart';

import 'package:gameku/model/api/api_service.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnailProvider extends ChangeNotifier {
  String _videoUrl = '';
  late VideoPlayerController _videoThumbnail;

  final ApiService apiService;
  bool isFetch = false;

  VideoThumbnailProvider({required this.apiService});

  VideoPlayerController? get videoController => _videoThumbnail;

  Future<dynamic> videoThumbnailProvider(id) async {
    final video = await apiService.getThumbnailVideo(id);
    _videoUrl = video.results[0].data.the480;
    _videoThumbnail = VideoPlayerController.network(_videoUrl)..initialize();
    isFetch = true;
    notifyListeners();

    return _videoUrl;
  }
}
