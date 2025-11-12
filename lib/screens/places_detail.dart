import 'package:expense_trakcer/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetailScree extends StatelessWidget {
  PlacesDetailScree({super.key, required this.place});
  Places place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title, style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "Your location latitude ${place.location.lat}] and longitude ${place.location.long}]",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
