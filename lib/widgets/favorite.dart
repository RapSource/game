import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/data/game_detail.dart';
import '../provider/database_provider.dart';

class FavoritePage extends StatelessWidget {
  final GameDetail gameFavorite;
  final int idFavorite;

  const FavoritePage({required this.gameFavorite, required this.idFavorite});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        var game = gameFavorite;
        return FutureBuilder<bool>(
            future: provider.isFavorited(game.id),
            builder: (context, snapshot) {
              var isFavorited = snapshot.data ?? false;
              return isFavorited
                  ? IconButton(
                      onPressed: () => provider.addFavorite(game),
                      icon: const Icon(Icons.favorite,
                          color: Colors.red, size: 32))
                  : IconButton(
                      onPressed: () => provider.removeFavorite(game.id),
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 32,
                      ));
            });
      },
    );
  }
}
