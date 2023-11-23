import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper{
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  Widget drawMapByPosition(double a, double b){
    
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(a, b),
      zoom: 17.2,
    );

    Set<Marker> _marker = {
      Marker(
        position: LatLng(a, b), 
        markerId: MarkerId("0"),
        infoWindow: InfoWindow(
          title: "북박스",
        ),
        )
    };

    return GoogleMap(
      markers: _marker,
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller){
        _mapController.complete(controller);
      },
    );
  }
}