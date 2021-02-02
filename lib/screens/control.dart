import 'package:lac/components/my_app_bar.dart';
import 'package:flutter/material.dart';

class ControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Control",
      ),
    );
  }
}
