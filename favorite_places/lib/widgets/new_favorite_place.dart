import 'dart:io';

import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewFavoritePlace extends ConsumerStatefulWidget {
  const NewFavoritePlace({super.key});

  @override
  ConsumerState<NewFavoritePlace> createState() => _NewFavoritePlaceState();
}

class _NewFavoritePlaceState extends ConsumerState<NewFavoritePlace> {
  final _titleController = TextEditingController();
  String _enteredTitle = "";
  File? _selectedImage;

  _addNewFavoritePlace() {
    _enteredTitle = _titleController.text;

    if (_enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }

    ref
        .read(favoritePlacesProvider.notifier)
        .addNewFavoritePlace(_enteredTitle, _selectedImage!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Favorite Place',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            ImageInput(
              onImagePicked: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: _addNewFavoritePlace,
              label: const Text(
                'Add Place',
              ),
            )
          ],
        ),
      ),
    );
  }
}
