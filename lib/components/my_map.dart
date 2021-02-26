import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lac/controllers/map_controller.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final MapController mapController = MapController.to;

  @override
  Widget build(BuildContext context) {
    return GetX<MapController>(builder: (mapController) {
      return GoogleMap(
        markers: Set<Marker>.of(mapController.markers.values),
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: mapController.center.value,
          zoom: 7.0,
        ),
        onMapCreated: mapController.onMapCreated,
        onCameraMove: mapController.onCameraMove,
        gestureRecognizers: Set()
          ..add(
            Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
          ),
      );
    });
  }
}
