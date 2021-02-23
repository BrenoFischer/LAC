import 'package:lac/components/last_location.dart';
import 'package:lac/components/my_app_bar.dart';
import 'package:lac/components/my_map.dart';
import 'package:lac/controllers/location_controller.dart';
import 'package:lac/ui/styles_config.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  final locationController = LocationController.to;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        title: "UAV Info",
      ),
      body: Container(
        height: size.height,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: SizeConfig.textMultiplier * 60,
              child: MyMap(),
            ),
            LastLocation(),
          ],
        ),
      ),
    );
  }
}
