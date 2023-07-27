import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/data/db/database_helper.dart';
import '../model/data/game_detail.dart';
import '../provider/database_provider.dart';

class FavoritePage extends StatelessWidget {
  final GameDetail gameFavorite;

  const FavoritePage({required this.gameFavorite});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<bool>(
              future: provider.isFavorited(gameFavorite.id),
              builder: (context, snapshot) {
                var isFavorited = snapshot.data ?? false;
                return isFavorited
                    ? IconButton(
                        onPressed: () => provider.removeFavorite(gameFavorite.id),
                        color: Colors.red,
                        icon: const Icon(Icons.favorite_border, size: 32))
                    : IconButton(
                        onPressed: () => provider.addFavorite(gameFavorite),
                        color: Colors.red,
                        icon: const Icon(Icons.favorite, size: 32));
              });
        },
      ),
    );
  }
}
