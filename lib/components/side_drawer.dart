import 'package:lac/ui/styles.dart';
import 'package:lac/ui/styles_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  String dropDownValue = "14 Bis";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              '',
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('assets/images/logo2.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: DropdownButton<String>(
              value: dropDownValue,
              icon: Icon(Icons.arrow_downward),
              isExpanded: true,
              iconSize: 24,
              elevation: 16,
              style: AppStyles.drawerTextStyle,
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropDownValue = newValue;
                });
              },
              items: <String>['14 Bis', 'Odyssey One', 'Death Star', 'X-Wing']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Divider(
            height: 40,
          ),
          ListTile(
            leading: Icon(
              Icons.input,
              size: SizeConfig.imageSizeMultiplier * 7,
            ),
            title: Text(
              'Elipse',
              style: AppStyles.drawerTextStyle,
            ),
            onTap: () => {},
          ),
          Divider(
            height: 30,
            thickness: 2,
          ),
          ListTile(
            leading: Icon(
              Icons.insert_invitation,
              size: SizeConfig.imageSizeMultiplier * 7,
            ),
            title: Text(
              'Patrol',
              style: AppStyles.drawerTextStyle,
            ),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
