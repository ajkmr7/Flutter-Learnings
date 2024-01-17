import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/widgets/favorite_place_details.dart';
import 'package:favorite_places/widgets/new_favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlaces extends ConsumerStatefulWidget {
  const FavoritePlaces({super.key});

  @override
  ConsumerState<FavoritePlaces> createState() => _FavoritePlacesState();
}

class _FavoritePlacesState extends ConsumerState<FavoritePlaces> {
  late Future<void> _favoritePlaces;

  @override
  initState() {
    super.initState();
    _favoritePlaces = ref.read(favoritePlacesProvider.notifier).loadPlaces();
  }

  _pushAddNewFavoritePlace(BuildContext context) {
    Navigator.of(context).push<FavoritePlace>(
      MaterialPageRoute(
        builder: (context) {
          return const NewFavoritePlace();
        },
      ),
    );
  }

  _pushFavoritePlaceDetails(BuildContext context, FavoritePlace place) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FavoritePlaceDetails(
          favoritePlace: place,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritePlaces = ref.watch(favoritePlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
        ),
        actions: [
          IconButton(
            onPressed: () => _pushAddNewFavoritePlace(context),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: favoritePlaces.isEmpty
          ? Center(
              child: Text(
                'No places added yet!',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            )
          : FutureBuilder(
              future: _favoritePlaces,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: favoritePlaces.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => _pushFavoritePlaceDetails(
                              context,
                              favoritePlaces[index],
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(favoritePlaces[index].image),
                            ),
                            title: Text(
                              favoritePlaces[index].title,
                            ),
                          );
                        },
                      );
              },
            ),
    );
  }
}
