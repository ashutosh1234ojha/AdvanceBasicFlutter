import 'dart:io';

import 'package:expense_trakcer/models/place.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
// import 'package:sqflite/sqlite.api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY_KEY,title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Places>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places =
        data
            .map(
              (row) => Places(
                id: row['id'] as String,
                title: row['title'] as String,
                image: File(row['image'] as String),
                location: PlaceLocation(
                  lat: row['lat'] as double,
                  long: row['lng'] as double,
                ),
              ),
            )
            .toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    final newPlace = Places(
      title: title,
      image: copiedImage,
      location: location,
    );

    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.lat,
      'lan': newPlace.location.long,
      'address': 'address',
    });

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Places>>(
      (ref) => UserPlacesNotifier(),
    );
