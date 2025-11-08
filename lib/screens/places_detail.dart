import 'package:expense_trakcer/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetailScree extends StatelessWidget {
  PlacesDetailScree({super.key, required this.place});
  Places place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name, style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          place.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
