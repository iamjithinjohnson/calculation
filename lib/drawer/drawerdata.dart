import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerData {
  final Text name;
  final Icon icons;
  DrawerData({
    this.name,
    this.icons,
  });
}

List<DrawerData> drawerData() {
  return <DrawerData>[
    DrawerData(
      name: Text('Privacy Policy'),
      icons: Icon(Icons.ac_unit_outlined),
    ),
    DrawerData(
      name: Text('Privacy Policy'),
      icons: Icon(Icons.ac_unit_outlined),
    ),
    DrawerData(
      name: Text('Privacy Policy'),
      icons: Icon(Icons.ac_unit_outlined),
    ),
    DrawerData(
      name: Text('Privacy Policy'),
      icons: Icon(Icons.ac_unit_outlined),
    ),
  ];
}
