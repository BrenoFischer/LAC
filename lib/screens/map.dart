import 'package:lac/components/my_app_bar.dart';
import 'package:lac/ui/styles_config.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "UAV Info",
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: SizeConfig.textMultiplier * 60,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
