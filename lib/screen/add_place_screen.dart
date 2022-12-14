import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_locations/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../widget/image_input.dart';
import '../widget/location_input.dart';

class AddPlace extends StatefulWidget {
   static const routeName = '/add-place';

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }
  void _selectPlace(double lat,double lng){
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }
  void savePlaces() {
    if(titleController.text.isEmpty || _pickedImage == null)
    {
      return;
    }
    Provider.of<GreatPlaces>(context,listen: false).addplaces(titleController.text, _pickedImage!,_pickedLocation!);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add A New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
         Expanded(
           child:SingleChildScrollView(
           child:Padding(
             padding: EdgeInsets.all(10),
             child: Column(
             children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                ),
               SizedBox(height: 10),
               ImageInput(_selectImage),
               SizedBox(height: 10),
               LocationInput(_selectPlace),
             ],
           ),
           ),
           ),
         ),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue[600]),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            onPressed: savePlaces,

          ),
        ],
      ),
    );
  }
}
