import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import 'map_screen.dart';

class PlacesDetailScreen extends StatelessWidget {
 static const routeName = '/pdscreen';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(context,listen: false).findById(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title!),),
    body: Column(
      children: <Widget>[
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(selectedPlace.location.address!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black45,
        ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (ctx) => MapScreen(
              initialLocation: selectedPlace.location,
            ),
            ),
          );
        },
            child: Text('View On Map'),
        ),
      ],
    ),

    );
  }
}
