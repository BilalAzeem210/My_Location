import 'package:flutter/material.dart';
import '../screen/map_screen.dart';
import '../screen/place_detail_screen.dart';
import './screen/place_list_screen.dart';
import './providers/great_places.dart';
import 'package:provider/provider.dart';
import './screen/add_place_screen.dart';

void main() {
  runApp(MyLocation());
}

class MyLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: GreatPlaces(),
         child: MaterialApp(
           debugShowCheckedModeBanner: false,
      title: 'GreatPlaces',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: PlaceList(),
           routes: {
             AddPlace.routeName: (ctx) => AddPlace(),
             MapScreen.routeName: (ctx) => MapScreen(),
             PlacesDetailScreen.routeName : (ctx) => PlacesDetailScreen(),
           },
    ),
    );
  }
}
