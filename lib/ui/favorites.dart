import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/controllers/favorite_provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer<FavoriteNotifier>(
        builder: (context, favoriteNotifier, child) {
          // Use favoriteNotifier.favorites to build the list of favorite items
          return ListView.builder(
            itemCount: favoriteNotifier.favorites.length,
            itemBuilder: (context, index) {
              // Build UI for each favorite item
              var favoriteItem = favoriteNotifier.favorites[index];
              return ListTile(
                title: Text(favoriteItem['name']),
                subtitle: Text(favoriteItem['category']),
                // Add other UI elements as per your requirements
              );
            },
          );
        },
      ),
    );
  }
}
