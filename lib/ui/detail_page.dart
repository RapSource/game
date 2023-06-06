import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_appbar.dart';
import 'package:readmore/readmore.dart';
import '../widgets/favorite.dart';
import 'package:video_player/video_player.dart';

import '../model/api/api_service.dart';
import '../model/data/game_detail.dart';
import '../model/data/screenshot.dart';

class DetailPage extends StatefulWidget {
  int? id;

  DetailPage({required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  VideoPlayerController? _controller;
  bool isPlaying = false;
  String videoUrl = '';
  late Future<ShortScreensShot> _ss;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var futureThumbVideo = await ApiService().getThumbnailVideo(widget.id);
      videoUrl = futureThumbVideo.results[0].data.the480;
      _controller = VideoPlayerController.network(videoUrl)..initialize();
    });
    _ss = ApiService().getScreenShot(widget.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: FutureBuilder(
            future: GameDetail.getGameDetail(widget.id),
            builder: (context, snapshot) {
              var gameDetail = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: [
                      Image.network(
                        gameDetail?.backgroundImage ??
                            'https://www.shutterstock.com/image-vector/vector-illustration-sample-red-grunge-600w-2065712915.jpg',
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
                            gameDetail?.name ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(141, 7, 119, 139),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(gameDetail?.getGenre().toString() ?? '', style: GoogleFonts.roboto(fontSize: 16.0)),
                          SizedBox(height: 5),
                          Container(
                            height: 200,
                            // color: Colors.amber,
                            child: FutureBuilder(
                                future:
                                    _ss,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          if (_controller != null)
                                            Container(
                                              margin: const EdgeInsets.all(8.0),
                                              height: 180,
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
                                                  child: VideoPlayer(_controller!),
                                                  ),
                                                  Center(
                                                    child: FloatingActionButton(
                                                      backgroundColor:
                                                          Colors.black38,
                                                      onPressed: () {
                                                        setState(() {
                                                          isPlaying = !isPlaying;
                                                          if (isPlaying) {
                                                            _controller?.play();
                                                          } else {
                                                            _controller?.pause();
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
                                            itemCount:
                                                snapshot.data?.results.length,
                                            itemBuilder: (context, index) {
                                              var ss =
                                                  snapshot.data?.results[index];
                                              return Container(
                                                margin:
                                                    const EdgeInsets.all(8.0),
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
                                                    ss?.image ??
                                                        'https://www.shutterstock.com/image-vector/vector-illustration-sample-red-grunge-600w-2065712915.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                }),
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            child: ReadMoreText(
                              gameDetail?.descriptionRaw ?? '',
                              trimLines: 10,
                              textAlign: TextAlign.justify,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Read More..',
                              trimExpandedText: 'Read Less..',
                              lessStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                              moreStyle: TextStyle(
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
            }));
  }
}
