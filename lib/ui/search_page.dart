import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/game_search_provider.dart';
import '../provider/result_state.dart';
import '../widgets/card_game.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  void initState() {
    Provider.of<SearchGameProvider>(context, listen: false).fetchSearchGame(query);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SearchGameProvider>(builder: (context, search, _) {
        if (search.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (search.state == ResultState.hasData) {
          // var gameSearch = search.resultSearch;
          return SafeArea(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 47, vertical: 10),
                  child: TextField(
                    onChanged: (String query) {
                      search.fetchSearchGame(query);
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 27),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      hintText: 'Search',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(child: CardGame(gameResult: search.resultSearch))
              ],
            ),
          );
        } else if (search.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(search.message),
            ),
          );
        } else if (search.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(search.message),
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
