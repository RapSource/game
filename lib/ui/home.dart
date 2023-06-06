import 'package:flutter/material.dart';
import 'package:gameku/model/api/api_service.dart';
import 'package:gameku/provider/game_provider.dart';
import 'package:gameku/widgets/custom_appbar.dart';
import 'package:gameku/ui/detail_page.dart';
import 'package:provider/provider.dart';

import '../model/data/game_result.dart';
import '../model/data/genres.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<GameResult> _gameResult;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gameResult = ApiService().getGameResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: Consumer<GameProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
              itemCount: state.result.results.length,
              itemBuilder: (context, index) {
                var game = state.result.results[index];
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
            } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
          }),
    );
  }
}
