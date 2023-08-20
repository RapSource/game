import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/api/api_service.dart';
import '../data/db/database_helper.dart';
import '../provider/database_provider.dart';
import '../provider/game_detail_provider.dart';
import '../provider/result_state.dart';
import '../provider/screenshot_provider.dart';
import '../provider/video_thumbnail_provider.dart';
import '../widgets/custom_appbar.dart';
import 'package:readmore/readmore.dart';
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
  void initState() {
    Provider.of<GameDetailProvider>(context, listen: false)
        .fetchDetailGame(widget.id);
    Provider.of<GameDetailProvider>(context, listen: false)
        .getDeveloper(widget.id);
    Provider.of<GameDetailProvider>(context, listen: false)
        .getPublisher(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ScreenShotProvider>(
            create: (_) => ScreenShotProvider(apiService: ApiService())),
        ChangeNotifierProvider<VideoThumbnailProvider>(
            create: (_) => VideoThumbnailProvider(apiService: ApiService())),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60), child: CustomAppBar()),
          body: Consumer<GameDetailProvider>(
            builder: (context, detail, _) {
              if (detail.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (detail.state == ResultState.hasData) {
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
                              Consumer<DatabaseProvider>(
                                builder: (context, provider, child) {
                                  return FutureBuilder<bool>(
                                      future: provider
                                          .isFavorited(detail.gameDetail.id),
                                      builder: (context, snapshot) {
                                        var isFavorited =
                                            snapshot.data ?? false;
                                        return isFavorited
                                            ? IconButton(
                                                onPressed: () =>
                                                    provider.removeFavorite(
                                                        detail.gameDetail.id),
                                                color: Colors.red,
                                                icon: const Icon(Icons.favorite,
                                                    size: 32))
                                            : IconButton(
                                                onPressed: () =>
                                                    provider.addFavorite(
                                                        detail.gameDetail),
                                                color: Colors.red,
                                                icon: const Icon(
                                                    Icons.favorite_border,
                                                    size: 32));
                                      });
                                },
                              ),
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
                            const SizedBox(height: 10),
                            Container(
                                height: 200,
                                child: Consumer<VideoThumbnailProvider>(
                                    builder: (context, video, _) {
                                  if (!video.isFetch) {
                                    video.videoThumbnailProvider(widget.id);
                                  }
                                  return Consumer<ScreenShotProvider>(
                                      builder: (context, ss, _) {
                                    if (!ss.isFetch) {
                                      ss.screenShotGame(widget.id);
                                    }
                                    if (ss.state == ResultState.loading) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                        color: Color.fromARGB(141, 7, 119, 139),
                                      ));
                                    } else if (ss.state ==
                                        ResultState.hasData) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            if (video.videoController !=
                                                null) ...[
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(8.0),
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
                                                          BorderRadius.circular(
                                                              10),
                                                      child: video.videoController !=
                                                              null
                                                          ? VideoPlayer(video
                                                              .videoController!)
                                                          : Container(),
                                                    ),
                                                    Center(
                                                      child:
                                                          FloatingActionButton(
                                                        backgroundColor:
                                                            Colors.white30,
                                                        onPressed: () {
                                                          setState(() {
                                                            isPlaying =
                                                                !isPlaying;
                                                            if (isPlaying) {
                                                              video
                                                                  .videoController
                                                                  ?.play();
                                                            } else {
                                                              video
                                                                  .videoController
                                                                  ?.pause();
                                                            }
                                                          });
                                                        },
                                                        child: Icon(
                                                          isPlaying
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  ss.screenShot.results.length,
                                              itemBuilder: (context, index) {
                                                ss.screenShot;
                                                return Container(
                                                  margin:
                                                      const EdgeInsets.all(8.0),
                                                  height: 170,
                                                  width: 270,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      ss.screenShot
                                                          .results[index].image,
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
                                trimCollapsedText: ' Show more..',
                                trimExpandedText: ' Show less..',
                                lessStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(141, 7, 119, 139)),
                                moreStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(141, 7, 119, 139)),
                                style: GoogleFonts.roboto(fontSize: 16.0),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: const Divider(
                                height: 20,
                                color: Colors.black45,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Developer',
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color.fromARGB(
                                                141, 7, 119, 139)),
                                      ),
                                      Text(
                                        detail.developer.name,
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Publisher',
                                          style: GoogleFonts.lato(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: const Color.fromARGB(
                                                  141, 7, 119, 139))),
                                      Text(
                                        detail.publisher.name,
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Released',
                                          style: GoogleFonts.lato(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: const Color.fromARGB(
                                                  141, 7, 119, 139))),
                                      Text(
                                        DateFormat("dd MMMM, yyyy").format(
                                            DateTime.parse(detail
                                                .gameDetail.released
                                                .toString())),
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 300,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 0, 4, 255),
                                      Color.fromARGB(255, 16, 242, 223)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight,
                                  ),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/patern.jpg'),
                                      opacity: 0.5,
                                      fit: BoxFit.none,
                                      repeat: ImageRepeat.repeat)),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                  onPressed: () async {
                                    final Uri url = Uri.parse(
                                        'https://${detail.gameDetail.storeUrl()}');
                                    Future<void> _launchUrl() async {
                                      if (!await launchUrl(url)) {
                                        throw Exception(
                                            'Could not launch $url');
                                      }
                                    }

                                    _launchUrl();
                                  },
                                  child: const Text(
                                    'Go To Store',
                                    style: TextStyle(
                                        color: Color.fromARGB(141, 7, 119, 139),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          )),
    );
  }
}
