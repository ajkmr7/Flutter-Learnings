import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import '../models/favorite_place.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE favorite_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class FavoritePlacesStateNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesStateNotifier() : super([]);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();

    final data = await db.query(
      'favorite_places',
    );
    final favoritePlaces = data.map((item) {
      return FavoritePlace(
        id: item['id'] as String,
        title: item['title'] as String,
        image: File(
          item['image'] as String,
        ),
      );
    }).toList();

    state = favoritePlaces;
  }

  addNewFavoritePlace(String title, File image) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = FavoritePlace(title: title, image: copiedImage);

    final db = await _getDatabase();

    db.insert(
      'favorite_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );

    state = [
      newPlace,
      ...state,
    ];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesStateNotifier, List<FavoritePlace>>(
        (ref) {
  return FavoritePlacesStateNotifier();
});
