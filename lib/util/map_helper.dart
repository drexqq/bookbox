import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Widget drawMapByPosition(double a, double b) {
    CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(a, b),
      zoom: 17.2,
    );

    Set<Marker> marker = {
      Marker(
        position: LatLng(a, b),
        markerId: const MarkerId("0"),
        infoWindow: const InfoWindow(
          title: "북박스",
        ),
      )
    };

    return GoogleMap(
      markers: marker,
      compassEnabled: false,
      trafficEnabled: false,
      zoomControlsEnabled: false,
      tiltGesturesEnabled: false,
      myLocationButtonEnabled: false,
      scrollGesturesEnabled: false,
      rotateGesturesEnabled: false,
      indoorViewEnabled: false,
      mapToolbarEnabled: false,
      zoomGesturesEnabled: false,
      myLocationEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }
}
