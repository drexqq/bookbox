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

  CameraPosition? currentPos;
  Future<void> getCurrentPos() async {
    final lastPosition = await Geolocator.getLastKnownPosition();
    if (lastPosition != null) {
      currentPos = CameraPosition(
          target: LatLng(lastPosition.latitude, lastPosition.longitude),
          zoom: 17);
      setState(() {});
    }

    final curPos = await Geolocator.getCurrentPosition();
    Geolocator.getPositionStream().listen((Position position) {
      currentPos = CameraPosition(
          target: LatLng(curPos.latitude, curPos.longitude), zoom: 17);
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
    return Scaffold(
      appBar: AppBar(title: const Text("[]에 위치한 북박스")),
      body: FutureBuilder(
        // TODO 매장 정보들 불러오기
        future: null,
        builder: (_, snapshot) {
          if (currentPos == null) {
            return const Center(child: Text("Loading Failed"));
          }
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: currentPos!,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              mapCtrl.complete(controller);
            },
          );
        },
      ),
    );
  }
}
