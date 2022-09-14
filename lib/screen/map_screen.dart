import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

    class MapScreen extends StatefulWidget {
      static const routeName = '/map-screen';

      final PlaceLocation initialLocation;
      final bool isSelecting;

      MapScreen({this.initialLocation = const PlaceLocation(latitude: 24.8693627,longitude: 67.0846322),this.isSelecting = false});
      @override
      State<MapScreen> createState() => _MapScreenState();
    }

    class _MapScreenState extends State<MapScreen> {
     LatLng? _pickedLocation;
     Set<Marker> _Markers = {};
      void _selectLocation (LatLng position) {
        setState(
            (){
              _pickedLocation = position;
              /*_Markers = {
                Marker(
                markerId: MarkerId("Marker 1"),
                position: _pickedLocation!,

              ),};*/
            print(_pickedLocation);
            }
        );
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Your Map'),
            actions: [
              if(widget.isSelecting) 
                IconButton(onPressed: _pickedLocation == null ? null : () {
                  Navigator.of(context).pop(_pickedLocation);
                },
                    icon: Icon(Icons.check)),
              
            ],
            
          ),
          body: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.initialLocation.latitude!,
                widget.initialLocation.longitude!,
              ),
              zoom: 19,
            ),
            onTap: widget.isSelecting ? _selectLocation : null,
            markers: _pickedLocation == null && widget.isSelecting
          ? {}
                  : {
          Marker(
          markerId: MarkerId('m1'),
          position: _pickedLocation ?? LatLng(
          widget.initialLocation.latitude!,
          widget.initialLocation.longitude!
          ),
          ),
          },
          ),
        );
      }
    }
