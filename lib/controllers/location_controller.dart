import 'package:lac/classes/location.dart';
import 'package:get/get.dart';
import 'package:lac/controllers/marker_controller.dart';

class LocationController extends GetxController {
  final locations = List<Location>().obs;
  final MarkerController markerController = MarkerController.to;

  static LocationController get to => Get.find<LocationController>();

  @override
  void onInit() {
    super.onInit();
  }

  addLocation(Location location) {
    int id;
    clearLocations();
    locations.add(location);
    if (location.data[0] < 0) {
      id = 1;
    } else {
      id = 2;
    }
    markerController.addMarker(location.data[0], location.data[1], id);
  }

  clearLocations() {
    locations.clear();
  }
}
