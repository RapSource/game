import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameku/widgets/favorite.dart';
import 'package:provider/provider.dart';

import '../provider/database_provider.dart';
import '../provider/result_state.dart';
import '../widgets/card_game.dart';
import '../widgets/platform_widget.dart';

class FavoriteList extends StatelessWidget {
  static const routeName = '/favorite_page';

  static const String favoriteTitle = 'Favorite';

  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(favoriteTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(favoriteTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: provider.favorite.length,
          itemBuilder: (context, index) {
            return ListView.builder(
              itemCount: FavoritePage.length,
              itemBuilder: (context, index) {
                var game = gameResult.results[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, DetailPage.routeName,
                          arguments: game.id);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
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
                              game.backgroundImage,
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  game.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
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
                                      const Text(
                                        'Genre:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(game.getGenre()),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Rating: '),
                                    Row(
                                      children: [
                                        const SizedBox(height: 5),
                                        Text(game.rating.toString()),
                                        const SizedBox(height: 5),
                                        const Icon(
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
          },
        );
      } else {
        return Center(
          child: Material(
            child: Text(provider.message),
          ),
        );
      }
    });
  }
}
