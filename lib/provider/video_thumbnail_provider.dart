import 'package:flutter/foundation.dart';

import 'package:gameku/model/api/api_service.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnailProvider extends ChangeNotifier {
  final ApiService apiService;

  VideoThumbnailProvider({required this.apiService});

  String _videoUrl = '';
  bool isFetch = false;
  late VideoPlayerController _videoThumbnail;
  VideoPlayerController get videoController => _videoThumbnail;

  Future<dynamic> videoThumbnailProvider(int id) async {
    final video = await apiService.getThumbnailVideo(id);
    _videoUrl = video.results[0].data.the480;
    _videoThumbnail = VideoPlayerController.network(_videoUrl)..initialize();
    isFetch = true;
    notifyListeners();
  }

  @override
  void dispose() {
    videoController.dispose();

    super.dispose();
  }
}
