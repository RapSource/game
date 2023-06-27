import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/api/api_service.dart';
import '../provider/game_detail_provider.dart';
import '../provider/screenshot_provide.dart';
import '../provider/video_thumbnail_provider.dart';
import '../widgets/custom_appbar.dart';
import 'package:readmore/readmore.dart';
import '../widgets/favorite.dart';
import 'package:video_player/video_player.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail_page';

  int id;

  DetailPage({required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoThumbnailProvider>(
      create: (_) => VideoThumbnailProvider(apiService: ApiService()),
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(60), child: CustomAppBar()),
          body: Consumer<GameDetailProvider>(
            builder: (context, detail, _) {
              detail.fetchDetailGame(widget.id);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: [
                      Image.network(
                        detail.gameDetail.backgroundImage,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      SafeArea(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                            ),
                            const LoveIcon(),
                          ],
                        ),
                      ))
                    ]),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            detail.gameDetail.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color.fromARGB(141, 7, 119, 139),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(detail.gameDetail.getGenre().toString(),
                              style: GoogleFonts.roboto(fontSize: 16.0)),
                          const SizedBox(height: 5),
                          Container(
                              height: 200,
                              child: Consumer<VideoThumbnailProvider>(
                                  builder: (context, video, _) {
                                if (!video.isFetch) {
                                  video.videoThumbnailProvider(widget.id);
                                }
                                return Consumer<ScreenShotProvider>(
                                    builder: (context, ss, _) {
                                  ss.screenShotGame(widget.id);
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(8.0),
                                          height: 1850,
                                          width: 270,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: VideoPlayer(
                                                    video.videoController),
                                              ),
                                              Center(
                                                child: FloatingActionButton(
                                                  backgroundColor: Colors.black26,
                                                  onPressed: () {
                                                    setState(() {
                                                      isPlaying = !isPlaying;
                                                      if (isPlaying) {
                                                        video.videoController
                                                            .play();
                                                      } else {
                                                        video.videoController
                                                            .pause();
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    isPlaying
                                                        ? Icons.pause
                                                        : Icons.play_arrow,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: ss.screenShot.results.length,
                                          itemBuilder: (context, index) {
                                            ss.screenShot;
                                            return Container(
                                              margin: const EdgeInsets.all(8.0),
                                              height: 170,
                                              width: 270,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  ss.screenShot.results[index]
                                                      .image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              })),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            child: ReadMoreText(
                              detail.gameDetail.descriptionRaw,
                              trimLines: 10,
                              textAlign: TextAlign.justify,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Read More..',
                              trimExpandedText: 'Read Less..',
                              lessStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                              moreStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                              style: GoogleFonts.poppins(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
