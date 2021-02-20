import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lac/classes/location.dart';
import 'package:lac/controllers/location_controller.dart';
import 'package:lac/ui/styles.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:usb_serial/usb_serial.dart';
import 'package:usb_serial/transaction.dart';

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  UsbPort _port;
  String _status = "Idle";
  List<Widget> _ports = [];
  List<Widget> _serialData = [];
  StreamSubscription<String> _subscription;
  Transaction<String> _transaction;
  int _deviceId;
  TextEditingController _textController = TextEditingController();
  final locationController = LocationController.to;

  Future<bool> _connectTo(device) async {
    _serialData.clear();

    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction.dispose();
      _transaction = null;
    }

    if (_port != null) {
      _port.close();
      _port = null;
    }

    if (device == null) {
      _deviceId = null;
      locationController.clearLocations();
      setState(() {
        _status = "Disconnected";
      });
      return true;
    }

    _port = await device.create();
    if (!await _port.open()) {
      setState(() {
        _status = "Failed to open port";
      });
      return false;
    }

    _deviceId = device.deviceId;
    await _port.setDTR(true);
    await _port.setRTS(true);
    await _port.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
      _port.inputStream,
      Uint8List.fromList([13, 10]),
    );

    _subscription = _transaction.stream.listen((String line) {
      setState(() {
        _serialData.add(Text(line));
        if (_serialData.length > 20) {
          _serialData.removeAt(0);
        }
        Map locationMap = jsonDecode(line);
        locationController.addLocation(Location.fromJson(locationMap));
      });
    });

    setState(() {
      _status = "Connected";
    });
    return true;
  }

  void _getPorts() async {
    _ports = [];
    List<UsbDevice> devices = await UsbSerial.listDevices();
    print(devices);

    devices.forEach((device) {
      _ports.add(ListTile(
          leading: Icon(Icons.usb),
          title: Text(device.productName),
          subtitle: Text(device.manufacturerName),
          trailing: RaisedButton(
            child:
                Text(_deviceId == device.deviceId ? "Disconnect" : "Connect"),
            onPressed: () {
              _connectTo(_deviceId == device.deviceId ? null : device)
                  .then((res) {
                _getPorts();
              });
            },
          )));
    });

    setState(() {
      print(_ports);
    });
  }

  @override
  void initState() {
    super.initState();

    UsbSerial.usbEventStream.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();
  }

  @override
  void dispose() {
    super.dispose();
    _connectTo(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USB Serial Plugin'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
                _ports.length > 0
                    ? "Available Serial Ports"
                    : "No serial devices available",
                style: AppStyles.drawerTextStyle),
            ..._ports,
            Text('Status: $_status\n'),
            ListTile(
              title: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Text To Send',
                ),
              ),
              trailing: RaisedButton(
                child: Text("Send"),
                onPressed: _port == null
                    ? null
                    : () async {
                        if (_port == null) {
                          return;
                        }
                        String data = _textController.text + "\n";
                        await _port.write(Uint8List.fromList(data.codeUnits));
                        _textController.text = "";
                      },
              ),
            ),
            //..._serialData,
            Text("Result Data", style: AppStyles.drawerTextStyle),
            Obx(() {
              return locationController.locations.length > 0
                  ? Text(locationController.locations.length.toString())
                  : Text("No JSON");
            })

            //_locations.length > 0
            //    ? SafeArea(
            //        child: Flexible(
            //          child: ListView.builder(
            //            shrinkWrap: true,
            //            physics: NeverScrollableScrollPhysics(),
            //            itemCount: _locations.length,
            //            itemBuilder: (context, index) {
            //              return Card(
            //                child: Column(
            //                  children: [
            //                    Text(_locations[index].sensor),
            //                    Text(_locations[index].time.toString()),
            //                    Text(_locations[index].data[0].toString()),
            //                    Text(_locations[index].data[1].toString()),
            //                  ],
            //                ),
            //              );
            //            },
            //          ),
            //        ),
            //      )
            //    : Center(
            //        child: Text("No JSON"),
            //      ),
          ],
        ),
      ),
    );
  }
}
