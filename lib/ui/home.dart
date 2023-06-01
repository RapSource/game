import 'package:flutter/material.dart';
import 'package:gameku/widgets/custom_appbar.dart';
import '../model/data/game.dart';
import 'package:gameku/ui/detail_page.dart';

import '../model/data/genres.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: FutureBuilder(
          future: Game.getGame(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.results.length,
              itemBuilder: (context, index) {
                var game = snapshot.data?.results[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(id: game?.id)
                        )
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      // padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 230, 228, 228),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.network(
                              game?.backgroundImage ??
                                  "https://www.shutterstock.com/image-vector/vector-illustration-sample-red-grunge-600w-2065712915.jpg",
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  game?.name ?? "",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Colors.black,
                                  ))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Genre:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      FutureBuilder(
                                        future: GenresDetail.getGenres(),
                                        builder: (context, snapshot) {
                                          var genres = snapshot.data?.results[index];
                                          return Text(
                                            genres?.name ?? ''
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Rating: '),
                                    Row(
                                      children: [
                                        SizedBox(height: 5),
                                        Text(game?.rating.toString() ?? ''),
                                        SizedBox(height: 5),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
