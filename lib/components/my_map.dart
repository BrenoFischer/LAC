import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:lac/controllers/marker_controller.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();
  final MarkerController markerController = MarkerController.to;

  static final CameraPosition initialPosition = CameraPosition(
    target: LatLng(53.2839936, -9.1187864),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return GetX<MarkerController>(builder: (markerController) {
      return GoogleMap(
        markers: Set<Marker>.of(markerController.markers.values),
        mapType: MapType.hybrid,
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        gestureRecognizers: Set()
          ..add(
            Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
          ),
      );
    });
  }
}
