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
  // static const String searchPage= 'Search';
  String query = '';

  void initState() {
    Provider.of<SearchGameProvider>(context, listen: false)
        .fetchSearchGame(query);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchGameProvider>(
      builder: (context, search, _) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/mobile-game.png',
                      fit: BoxFit.contain,
                      height: 35,
                    ),
                    Container(
                        width: 320,
                        height: 40,
                        margin: const EdgeInsets.all(7),
                        child: TextField(
                          onChanged: (query) {
                            search.fetchSearchGame(query);
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 27),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {},
                            ),
                            hintText: 'Search',
                          ),
                        ))
                  ],
                ),
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 0, 4, 255),
                          Color.fromARGB(255, 16, 242, 223)
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                      ),
                      image: DecorationImage(
                          image: AssetImage('assets/images/patern.jpg'),
                          opacity: 0.5,
                          fit: BoxFit.none,
                          repeat: ImageRepeat.repeat)),
                ),
              ),
            ),
            body: _buildList(search));
      },
    );
  }

  _buildList(SearchGameProvider search) {
    if (search.state == ResultState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (search.state == ResultState.hasData) {
      var searchGame = search.resultSearch;
      return CardGame(gameResult: searchGame);
    } else if (search.state == ResultState.noData) {
      return Center(
        child: Material(
          child: Text(search.message),
        ),
      );
    } else if (search.state == ResultState.error) {
      return const Center(
        child: Material(
          child: Text(
            'Games not found',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
          ),
        ),
      );
    } else {
      return const Center(
        child: Material(
          child: Text(''),
        ),
      );
    }
  }
}
