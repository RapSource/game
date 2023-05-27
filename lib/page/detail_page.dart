import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import '../model/data/game.dart';
import '../model/data/game_detail.dart';
import '../model/data/screenshot.dart';
import '../utils/custom_appbar.dart';

class DetailPage extends StatelessWidget {
  int? id;

  DetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: FutureBuilder(
            future: GameDetail.getGameDetail(id),
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
                            // const LoveIcon(),
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
                          Text(gameDetail?.getGenre().toString() ?? ''),
                          SizedBox(height: 5),
                          Container(
                            height: 200,
                            color: Colors.amber,
                            child: FutureBuilder(
                              future: ResultScreenShot.getScreenShot(id),
                              builder: (context, snapshot) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(8.0),
                                        // color: Colors.blue,
                                        height: 180,
                                        width: 270,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            'https://www.shutterstock.com/image-vector/vector-illustration-sample-red-grunge-600w-2065712915.jpg',
                                            fit: BoxFit.cover,
                                          ),
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
                              },
                            ),
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
