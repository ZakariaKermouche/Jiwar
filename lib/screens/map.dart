import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dir_khir/model/Category.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as local;

//import 'package:search_map_place/search_map_place.dart';

Category choice = Category();
final Map<String, Marker> _markers = {};

class MapPage extends StatefulWidget {
  static String id = 'map';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            MyMap(),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Search(),
                CategoryRow()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CategoryRow extends StatefulWidget {
  @override
  _CategoryRowState createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  Category selectedChoice = Category();
  List<Widget> _buildCategoriesChips() {
    List<Widget> choices = List();
    categories.forEach((item) {
      choices.add(Container(
        padding: EdgeInsets.all(5.0),
        child: ChoiceChip(
          elevation: 0.0, //to change
          label: Text(
            item.name,
          ),
          labelPadding: EdgeInsets.all(6.0),
          labelStyle: TextStyle(
            color: item.color,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          avatar: CircleAvatar(
            backgroundColor: item.color,
            child: Icon(
              item.icon,
              color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: item.color.withOpacity(0.4),
          selected: choice.name == item.name,
          onSelected: (selected) {
            setState(() {
              choice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _buildCategoriesChips(),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController controller;
  static LatLng _initialPosition;
  var location = new local.Location();
//  Marker darnaMarker=Marker(
//    markerId: MarkerId('darzo'),
//    position: LatLng(36.733332, 3.093334),
//    infoWindow: InfoWindow(title: 'Los Zozilos'),
//    icon: BitmapDescriptor.defaultMarkerWithHue(
//    BitmapDescriptor.hueViolet,
//    ),
//  );

  @override
  void initState() {
    super.initState();
    _currentLocalisation();
  }

  _onMapCreated(controller) {
    Completer<GoogleMapController> _controller = Completer();
    _controller.complete(controller);
  }

  Future _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(36.79155991, 3.2855173),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }

  _currentLocalisation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  static final CameraPosition _currentPosition = CameraPosition(
    target: LatLng(_initialPosition.latitude, _initialPosition.longitude),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //height: MediaQuery.of(context).size.height,
      //width: MediaQuery.of(context).size.width,
      /*child: */ body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom:
                12), //CameraPosition(target: LatLng(36.733332, 3.093334), zoom: 12),
        onMapCreated: _onMapCreated(controller),
        markers: _markers.values.toSet(),
//        {
//          darnaMarker,
//       }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
//        onPressed: () async {
//
//        var currentLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//          setState(() {
//            //_markers.clear();
//
//
//            final marker = Marker(
//              markerId: MarkerId("curr_loc"),
//              position: LatLng(currentLocation.latitude, currentLocation.longitude),
//              infoWindow: InfoWindow(title: 'Your Location'),
//            );
//            _markers["Current Location"] = marker;
//          });
//        },//_getLocation(),
        tooltip: 'Get Location',
        child: Icon(Icons.location_on),
      ),
    );
  }
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        hintColor: Colors.white,
      ),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "Seach...",
            hintStyle: TextStyle(
              color: Color(0xFF757575),
              fontSize: 20,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xFF757575),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            contentPadding: EdgeInsets.symmetric(),
            fillColor: Color(0xFFFFFFFF),
            filled: true,
          ),
        ),
      ),
    );
  }
}

/*
    Completer<GoogleMapController> _controller = Completer();
    Location location = new Location(); 
    GoogleMapController controller;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(36.733332, 3.093334), zoom: 12),
        onMapCreated: (controller) {
            _controller.complete(controller);
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        markers:{
          darnaMarker,
       }
      )
    )
    _animateToUser() async {
      var pos = await location.getLocation();
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 17.0,
        )
      )
      );
    }

  */
/*
  Widget _searchBarMap(BuildContext context){
    return SearchMapPlaceWidget(
    apiKey: "AIzaSyArvPT3SD1NL-MIipePLJbZaGOw5jt8agM",
    // The language of the autocompletion
    language: 'en',
    // The position used to give better recomendations. In this case we are using the user position
    location: userPosition.coordinates,
    radius: 30000,
    onSelected: (Place place) async {
        final geolocation = await place.geolocation;

        // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
        final GoogleMapController controller = await _mapController.future;
        controller.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
        controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
    },
);
  }
*/
