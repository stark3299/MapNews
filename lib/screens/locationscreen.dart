import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_news/components/newscache.dart';
import 'package:map_news/screens/mapnews.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng position;

  var feature;

  Marker myMarker;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  getUserLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(_locationData.latitude, _locationData.longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
  }

  Future<void> goToTheLake() async {
    await getUserLocation();
    setState(() {
      position = LatLng(_locationData.latitude, _locationData.longitude);
    });
  }

  @override
  void initState() {
    position = LatLng(0, 0);
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myMarker = Marker(
        infoWindow: InfoWindow(
          title: "Tap to See News",
          snippet: feature.toString(),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => MapNews(location: feature,newslist: NewsCache.news,)
            ));
          }
        ),
        markerId: new MarkerId("myMarker"),
        position: position,
        onTap: () async {
          print(position);
          final coordinates =
              Coordinates(position.latitude, position.longitude);
          var loc =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);

          setState(() {
            feature = loc.first.adminArea ?? loc.first.countryCode;
          });

          NewsCache.getNews(location: feature);


        });
    return GoogleMap(
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onTap: (value) async {
        print(value);
        var loc = await Geocoder.local.findAddressesFromCoordinates(Coordinates(value.latitude,value.longitude));

        setState(() {
          feature = loc.first.adminArea ?? loc.first.countryCode;
          position = value;
        });

      },
      markers: Set.from([myMarker]),
    );
  }
}
