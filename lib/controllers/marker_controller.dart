import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerController extends GetxController {
  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  static MarkerController get to => Get.find<MarkerController>();

  @override
  void onInit() {
    super.onInit();
  }

  void addMarker(double lat, double lng, int id) {
    final MarkerId markerId = MarkerId(id.toString());

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lng),
    );

    markers[markerId] = marker;
  }
}
