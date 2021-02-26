import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  Rx<LatLng> center = LatLng(0, 0).obs;
  Completer<GoogleMapController> gmapController = Completer();
  LatLng lastMapPosition;
  BitmapDescriptor pinIcon;

  static MapController get to => Get.find<MapController>();

  @override
  void onInit() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(24, 24)), 'assets/images/pin.png')
        .then((d) {
      pinIcon = d;
    });

    center.value = LatLng(53.2839936, -9.302038);
    super.onInit();
  }

  void addMarker(double lat, double lng, int id) {
    clearMarkers();
    final MarkerId markerId = MarkerId(id.toString());

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: id.toString()),
      icon: pinIcon,
    );

    markers[markerId] = marker;
    center.value = LatLng(lat, lng);
    gmapController.future.then(
        (value) => value.moveCamera(CameraUpdate.newLatLng(center.value)));
    update();
  }

  void clearMarkers() {
    markers.clear();
  }

  void onMapCreated(GoogleMapController controller) {
    gmapController.complete(controller);
  }

  void onCameraMove(CameraPosition position) {
    lastMapPosition = position.target;
  }
}
