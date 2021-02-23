import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lac/classes/location.dart';
import 'package:get/get.dart';
import 'package:lac/controllers/location_controller.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

class UsbController extends GetxController {
  final status = "Idle".obs;
  final ports = <Widget>[].obs;
  UsbPort port;
  StreamSubscription<String> _subscription;
  Transaction<String> _transaction;
  final deviceId = 0.obs;

  final locationController = LocationController.to;

  static UsbController get to => Get.find<UsbController>();

  handleSend(TextEditingController textController) async {
    if (port == null) {
      return null;
    } else {
      String data = textController.text + "\n";
      await port.write(Uint8List.fromList(data.codeUnits));
      textController.text = "";
      update();
    }
  }

  Future<bool> _connectTo(device) async {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction.dispose();
      _transaction = null;
    }

    if (port != null) {
      port.close();
      port = null;
    }

    if (device == null) {
      deviceId.value = 0;
      locationController.clearLocations();
      status.value = "Disconnected";
      update();
      return true;
    }

    port = await device.create();
    if (!await port.open()) {
      status.value = "Failed to open port";
      return false;
    }

    deviceId.value = device.deviceId;
    await port.setDTR(true);
    await port.setRTS(true);
    await port.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
      port.inputStream,
      Uint8List.fromList([13, 10]),
    );

    _subscription = _transaction.stream.listen((String line) {
      Map locationMap = jsonDecode(line);
      locationController.addLocation(Location.fromJson(locationMap));
      update();
    });

    status.value = "Connected";
    return true;
  }

  void _getPorts() async {
    ports.clear();
    List<UsbDevice> devices = await UsbSerial.listDevices();

    devices.forEach((device) {
      ports.add(
        ListTile(
          leading: Icon(Icons.usb),
          title: Text(device.productName),
          subtitle: Text(device.manufacturerName),
          trailing: RaisedButton(
            child: Text(
                deviceId.value == device.deviceId ? "Disconnect" : "Connect"),
            onPressed: () {
              _connectTo(deviceId.value == device.deviceId ? null : device)
                  .then((res) {
                _getPorts();
              });
            },
          ),
        ),
      );
    });
  }

  @override
  void onInit() {
    UsbSerial.usbEventStream.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();
    super.onInit();
  }
}
