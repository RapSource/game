import 'package:flutter/material.dart';
import 'package:gameku/provider/game_provider.dart';
import 'package:gameku/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../widgets/card_game.dart';

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
      body: Consumer<GameProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          var gameResult = state.result;
          return CardGame(gameResult: gameResult);
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
