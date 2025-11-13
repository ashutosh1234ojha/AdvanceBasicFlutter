import 'dart:io';

import 'package:expense_trakcer/models/place.dart';
import 'package:expense_trakcer/providers/user_places.dart';
import 'package:expense_trakcer/widgets/image_input.dart';
import 'package:expense_trakcer/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlaces extends ConsumerStatefulWidget {
  const AddNewPlaces({super.key});
  @override
  ConsumerState<AddNewPlaces> createState() {
    return _AddNewPlacesState();
  }
}

class _AddNewPlacesState extends ConsumerState<AddNewPlaces> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;
  bool _isTitleFieldEmpty = false;

  void _savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      if (enteredText.isEmpty) {
        setState(() {
          _isTitleFieldEmpty = true;
        });
      }
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredText, _selectedImage!, _selectedLocation!);
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
      appBar: AppBar(title: const Text("Add new place")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _isTitleFieldEmpty = false;
                });
              },
              decoration: const InputDecoration(labelText: "Title"),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),

            if (_isTitleFieldEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Title is empty",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.red),
                ),
              ),

            SizedBox(height: 10),

            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            SizedBox(height: 16),
            LocationInput(
              onLocationPicked: (location) {
                _selectedLocation = location;
              },
            ),
            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                _savePlace();
              },
              icon: Icon(Icons.add),
              label: const Text("Add Place"),
            ),
          ],
        ),
      ),
    );
  }
}
