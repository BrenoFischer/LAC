import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lac/controllers/location_controller.dart';
import 'package:lac/ui/styles.dart';

class LocationsListView extends StatelessWidget {
  final locationController = LocationController.to;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return locationController.locations.length == 0
          ? Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "No Locations",
                style: AppStyles.drawerTextStyle,
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: locationController.locations.length,
              itemBuilder: (c, i) {
                final location = locationController.locations[i];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.grey[100],
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Icon(Icons.location_on_outlined),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              location.sensor,
                              style: AppStyles.listCardTitle,
                            ),
                          ),
                          Text(
                            "Lat: " + location.data[0].toString(),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, top: 2),
                            child: Text(
                              "Lng: " + location.data[1].toString(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
    });
  }
}
