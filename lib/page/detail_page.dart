import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                          Text(
                            gameDetail?.getGenre().toString() ?? ''
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 150,
                            child: FutureBuilder(
                              future: ResultScreenShot.getScreenShot(id),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data?.results.length,
                                  itemBuilder: (context, index) {
                                    var ss = snapshot.data?.results[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 200,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color:
                                              Color.fromARGB(255, 230, 228, 228),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            ss?.image ?? 
                                            'https://www.shutterstock.com/image-vector/vector-illustration-sample-red-grunge-600w-2065712915.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                              );
                              },
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  gameDetail?.descriptionRaw ?? '',
                                  maxLines: 10,
                                  // textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(fontSize: 16.0),
                                ),
                              ],
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
