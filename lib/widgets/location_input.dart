import 'package:expense_trakcer/models/place.dart';
import 'package:expense_trakcer/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  LocationInput({super.key, required this.onLocationPicked});

  final void Function(PlaceLocation image) onLocationPicked;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;
  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    if (locationData.latitude == null || locationData.longitude == null) return;

    setState(() {
      _pickedLocation = PlaceLocation(
        lat: locationData.latitude!!,
        long: locationData.longitude!!,
      );
      _isGettingLocation = false;
    });

    widget.onLocationPicked(_pickedLocation!!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      "No location choosen",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    );

    if (_isGettingLocation) {
      previewContent = CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 170,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              onPressed: () {
                _getCurrentLocation();
              },
              label: Text("Get current location"),
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (ctx) => const MapScreen()));
              },
              label: Text("Select on Map"),
            ),
          ],
        ),
      ],
    );
  }
}
