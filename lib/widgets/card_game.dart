import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/data/game_result.dart';
import '../ui/detail_page.dart';

class CardGame extends StatelessWidget {
  final GameResult gameResult;

  const CardGame({required this.gameResult});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gameResult.results.length,
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
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.black,
                          ))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Rating: '),
                            Row(
                              children: [
                                const SizedBox(height: 5),
                                Text(game.rating.toString()),
                                const SizedBox(height: 5),
                                const Icon(
                                  Icons.star,
                                  color: Colors.orangeAccent,
                                  size: 18,
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
  }
}
