import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/data/game_detail.dart';
import '../provider/database_provider.dart';

class FavoritePage extends StatelessWidget {
  final GameDetail gameFavorite;

  const FavoritePage({required this.gameFavorite});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        var game = gameFavorite.id;
        return FutureBuilder<bool>(
            future: provider.isFavorited(game),
            builder: (context, snapshot) {
              var isFavorited = snapshot.data ?? false;
              return isFavorited
                  ? IconButton(
                      onPressed: () => provider.addFavorite(gameFavorite),
                      icon: const Icon(Icons.favorite, color: Colors.red, size: 32))
                  : IconButton(
                      onPressed: () => provider.removeFavorite(game),
                      icon: const Icon(Icons.favorite_border, size: 32,));
            });
      },
    );
  }
}
