import 'package:flutter/material.dart';

import 'package:favorite_places/models/favorite_place.dart';

class FavoritePlaceDetails extends StatelessWidget {
  const FavoritePlaceDetails({super.key, required this.favoritePlace});

  final FavoritePlace favoritePlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          favoritePlace.title,
        ),
      ),
      body: Stack(
        children: [
          Image.file(
            favoritePlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
