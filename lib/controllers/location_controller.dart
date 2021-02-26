import 'package:lac/classes/location.dart';
import 'package:get/get.dart';
import 'package:lac/controllers/map_controller.dart';

class LocationController extends GetxController {
  final locations = List<Location>().obs;
  final MapController mapController = MapController.to;

  static LocationController get to => Get.find<LocationController>();

  @override
  void onInit() {
    super.onInit();
  }

  addLocation(Location location) {
    clearLocations();
    locations.add(location);
    mapController.addMarker(location.lat, location.lng, location.id);
  }

  clearLocations() {
    locations.clear();
  }
}
