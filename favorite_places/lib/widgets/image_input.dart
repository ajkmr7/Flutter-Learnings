import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onImagePicked});

  final void Function(File) onImagePicked;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _picture;
  _takePicture() async {
    var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage == null) {
      return;
    }
    setState(
      () {
        _picture = File(pickedImage.path);
      },
    );
    widget.onImagePicked(_picture!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: _picture == null
          ? TextButton.icon(
              onPressed: _takePicture,
              icon: const Icon(
                Icons.camera,
              ),
              label: const Text(
                'Take a picture',
              ),
            )
          : GestureDetector(
              onTap: _takePicture,
              child: Image.file(
                _picture!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
    );
  }
}
