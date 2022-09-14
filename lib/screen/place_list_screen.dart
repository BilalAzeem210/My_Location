
import 'package:flutter/material.dart';
import 'package:my_locations/providers/great_places.dart';
import 'package:my_locations/screen/place_detail_screen.dart';
import 'package:provider/provider.dart';

import '../helpers/db_helper.dart';
import 'add_place_screen.dart';


class PlaceList extends StatefulWidget {
  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: <Widget>[
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(AddPlace.routeName);
          },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future:Provider.of<GreatPlaces>(context,listen: false).fetchAndSetPlaces(),
        builder: (ctx,snapshot) => snapshot.connectionState ==
            ConnectionState.waiting ?
        Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<GreatPlaces>(
          child: const Center(
            child: Text("Got no Places Yet, start adding some!"),
          ),
          builder: (ctx, greatPlaces, ch){

            return greatPlaces.items.length <= 0
                ? ch! : ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (ctx, i){
                  return Card(
                    elevation: 5,
                    child: ListTile(

                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          greatPlaces.items[i].image,
                        ),

                      ),
                      title:Text(greatPlaces.items[i].title!),
                      subtitle: Text(greatPlaces.items[i].location.address!),
                      onTap: (){
                          Navigator.of(context).pushNamed(
                            PlacesDetailScreen.routeName,
                            arguments: greatPlaces.items[i].id,
                          );
                      },
                      trailing: Container(
                        child: IconButton(onPressed: ()
                        {
                          DBHelper.deletedata('user_places', greatPlaces.items[i].id as String);

                          setState(() {
                              greatPlaces.items.removeAt(i);
                          });
                        },
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                      ),

                    ),
                  );

                });
          },

        ),
      ),
    );
  }
}



