
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';

import '../models/place.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier
{
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

    Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
    }

     Future<void> addplaces(String pickedTitle, File pickedImage,PlaceLocation pickedLocation)async {
    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude!, pickedLocation.longitude!);
    final updateLocation = PlaceLocation(latitude: pickedLocation.latitude, longitude: pickedLocation.longitude,address: address);
    final newPlace = Place(id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: updateLocation);
    _items.add(newPlace);
    notifyListeners();
    print('Your New Places:');
    print(newPlace);
    DBHelper.insert('user_places', {
      'id' : newPlace.id as String,
      'title' : newPlace.title as String,
      'image' : newPlace.image.path,
      'loc_lat' : newPlace.location.latitude!,
      'loc_lng' : newPlace.location.longitude!,
      'address' : newPlace.location.address!,

    });
  }
  Future<void> fetchAndSetPlaces() async{
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map((item) => Place(id: item['id'],
        title: item['title'],
        image: File(item['image'],),
        location: PlaceLocation(latitude: item['loc_lat'],longitude: item['loc_lng'],address: item['address']),
    ),
    ).toList();
  notifyListeners();
  }
/*
 Future<void> deleteItems(String id) async{
   final db = await DBHelper.database();
    return await db.deletedata('user_places', id);
}*/

}