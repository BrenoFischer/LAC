import 'package:lac/classes/location.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final locations = List<Location>().obs;

  static LocationController get to => Get.find<LocationController>();

  @override
  void onInit() {
    super.onInit();
  }

  addLocation(Location location) {
    locations.add(location);
  }

  clearLocations() {
    locations.clear();
  }
}
