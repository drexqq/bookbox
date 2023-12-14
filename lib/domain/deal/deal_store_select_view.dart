import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/deal/provider/deal_provider.dart';
import 'package:bookbox/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class DealStoreSelectView extends ConsumerStatefulWidget {
  const DealStoreSelectView({super.key});

  @override
  ConsumerState<DealStoreSelectView> createState() =>
      _DealStoreSelectViewState();
}

class _DealStoreSelectViewState extends ConsumerState<DealStoreSelectView> {
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
    setMarkers();
  }

  Set<Marker> mapMarkers = {};
  Future<void> setMarkers() async {
    final stores = await ref.read(dealNotifierProvider).getStores() as List;
    stores.removeWhere((e) =>
        e["B_STORE_POSITION"] == ";" ||
        e["B_STORE_POSITION"] == ";;" ||
        e["B_STORE_POSITION"] == null);
    final markers = stores.map((e) {
      final pos = e["B_STORE_POSITION"].split(";;");
      final marker = Marker(
        markerId: MarkerId(e["B_STORE_SEQ"]),
        position: LatLng(double.parse(pos[0]), double.parse(pos[1])),
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return _bottomSheet(e);
              });
        },
      );
      return marker;
    }).toSet();
    mapMarkers = markers;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("야탑동에 위치한 북박스")),
      body: FutureBuilder(
        // TODO 매장 정보들 불러오기
        future: ref.read(dealNotifierProvider).getStores(),
        builder: (_, snapshot) {
          if (currentPos == null || !snapshot.hasData) {
            return const Center(child: Text("Loading Failed"));
          }
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: currentPos!,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: mapMarkers,
            onMapCreated: (GoogleMapController controller) {
              mapCtrl.complete(controller);
            },
          );
        },
      ),
    );
  }

  Widget _bottomSheet(Map<String, dynamic> data) {
    return Wrap(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(data["B_STORE_NAME"]),
                  Text(data["B_STORE_ADDRESS"]),
                  Text("5칸 가능 (총 5칸) | ${data["B_STORE_BBOX"]}"),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("평일 : 09:00 ~ 18:00"),
                      Text("주말 : 09:00 ~ 18:00"),
                      Text("공휴일 : 영업 안함"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    padding: const EdgeInsets.all(20)),
                onPressed: () {
                  ref.read(dealRequestProvider).setStoreId(data["B_STORE_SEQ"]);
                  ref
                      .read(dealRequestProvider)
                      .setStoreName(data["B_STORE_NAME"]);
                  ref
                      .read(dealRequestProvider)
                      .setStorePosition(data["B_STORE_POSITION"]);
                  ref
                      .read(dealRequestProvider)
                      .setStoreAddress(data["B_STORE_ADDRESS"]);
                  context.router.push(const DealOrderPageRoute());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  child: Center(
                    child: Text("선택",
                        style:
                            TextStyle(fontSize: 20.spMin, color: Colors.white)),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
