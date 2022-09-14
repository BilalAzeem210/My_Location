
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../screen/map_screen.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat,double lng){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,

    );
    setState(()
    {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.longitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
      print(locData.latitude);
      print(locData.longitude);
    }
    catch(error){
      return;
    }
  }
  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
        isSelecting: true,
      ),
      ),
    );
    if(selectedLocation == null)
    {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude,selectedLocation.longitude);
    print(selectedLocation.latitude);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null ?
              const Text('No Location Chosen',
              textAlign: TextAlign.center,
              ) :
              Image.network(_previewImageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(onPressed: _getCurrentLocation,
                icon:const Icon(
                  Icons.location_on,
                ),
                label: const Text('Current Location'),
            ),
            TextButton.icon(onPressed: _selectOnMap,
              icon: const Icon(
                Icons.map,
              ),
              label: const Text('Select on Map'),
            ),

          ],
        )
      ],
    );
  }
}
