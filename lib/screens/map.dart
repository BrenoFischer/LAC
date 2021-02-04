import 'package:lac/components/my_app_bar.dart';
import 'package:lac/components/my_map.dart';
import 'package:lac/components/side_drawer.dart';
import 'package:lac/ui/styles_config.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "UAV Info",
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: SizeConfig.textMultiplier * 60,
                child: MyMap(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
