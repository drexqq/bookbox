import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class DealStoreSelectView extends StatefulWidget {
  const DealStoreSelectView({super.key});

  @override
  State<DealStoreSelectView> createState() => _DealStoreSelectViewState();
}

class _DealStoreSelectViewState extends State<DealStoreSelectView> {
  final Completer<GoogleMapController> mapCtrl =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  CameraPosition? currentPos;
  Future<void> getCurrentPos() async {
    final lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    if (lastPosition != null) {
      currentPos = CameraPosition(
          target: LatLng(lastPosition.latitude, lastPosition.longitude));
      setState(() {});
    }

    final curPos = await Geolocator.getCurrentPosition();
    Geolocator.getPositionStream().listen((Position position) {
      currentPos =
          CameraPosition(target: LatLng(curPos.latitude, curPos.longitude));
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentPos();
  }

  @override
  Widget build(BuildContext context) {
    print(currentPos);

    return Scaffold(
      appBar: AppBar(title: const Text("[]에 위치한 북박스")),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          mapCtrl.complete(controller);
        },
      ),
      // body: FutureBuilder(
      //   // TODO 매장 정보들 불러오기
      //   future: null,
      //   builder: (_, snapshot) {
      //     if (currentPos == null) {
      //       print(currentPos);
      //       return const Center(child: Text("Loading Failed"));
      //     }
      //     print(currentPos);
      //     return GoogleMap(
      //       mapType: MapType.hybrid,
      //       initialCameraPosition: _kGooglePlex,
      //       onMapCreated: (GoogleMapController controller) {
      //         mapCtrl.complete(controller);
      //       },
      //     );
      //   },
      // ),
    );
  }
}
