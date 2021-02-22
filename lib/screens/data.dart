import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:lac/components/locations_list.dart';
import 'package:lac/components/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lac/controllers/location_controller.dart';
import 'package:lac/controllers/usb_controller.dart';
import 'package:lac/ui/styles.dart';

class DataScreen extends StatelessWidget {
  final usbController = UsbController.to;
  final locationController = LocationController.to;

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    var stat = usbController.status;
    return Scaffold(
      appBar: MyAppBar(
        title: 'USB Serial Plugin',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Text(
                usbController.ports.length > 0
                    ? "Available Serial Ports"
                    : "No serial devices available",
                style: AppStyles.drawerTextStyle,
              ),
            ),
            usbController.ports.length > 0
                ? Obx(
                    () => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: usbController.ports.length,
                        itemBuilder: (context, index) {
                          return usbController.ports[index];
                        }),
                  )
                : Container(),
            Obx(
              () => Text('Status: $stat\n'),
            ),
            ListTile(
              title: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Text to Send',
                ),
              ),
              trailing: RaisedButton(
                child: Text("Send"),
                onPressed: () async {
                  usbController.handleSend(_textController);
                },
              ),
            ),
            Text("Result Data", style: AppStyles.drawerTextStyle),
            LocationsListView(),
          ],
        ),
      ),
    );
  }
}
