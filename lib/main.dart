import 'package:get/get.dart';
import 'package:lac/controllers/location_controller.dart';
import 'package:lac/screens/temporario.dart';
import 'package:lac/screens/welcome.dart';
import 'package:lac/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:lac/ui/styles_config.dart';

void main() {
  Get.put(LocationController());
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Drone Control',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
              headline6: AppStyles.appBarTitle,
            ),
          ),
          home: Teste(),
        );
      });
    });
  }
}
