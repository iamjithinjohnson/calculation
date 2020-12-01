import 'package:calculation/drawer/drawerdata.dart';
import 'package:calculation/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<DrawerData> drawerdata = drawerData();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      color: white.withOpacity(1),
      child: ListView.builder(
          itemCount: drawerdata.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: drawerdata[index].icons,
              title: drawerdata[index].name,
              onTap: () {
                //enter something
              },
            );
          }),
    );
  }
}
