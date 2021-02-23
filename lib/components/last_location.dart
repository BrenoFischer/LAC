import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lac/controllers/location_controller.dart';
import 'package:lac/ui/styles.dart';

class LastLocation extends StatelessWidget {
  final locationController = LocationController.to;
  @override
  Widget build(BuildContext context) {
    return GetX<LocationController>(
      builder: (locationController) {
        if (locationController.locations.length == 0) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              child: Text("No locations"),
            ),
          );
        }
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
                      locationController.locations[0].sensor,
                      style: AppStyles.listCardTitle,
                    ),
                  ),
                  Text(
                    "Lat: " +
                        locationController.locations[0].data[0].toString(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5, top: 2),
                    child: Text(
                      "Lng: " +
                          locationController.locations[0].data[1].toString(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
