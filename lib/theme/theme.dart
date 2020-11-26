import 'package:flutter/material.dart';

//  ##### COLOR #####

Color bluegrey = Colors.blueGrey;
Color blue = Colors.blue;
Color yellow = Colors.yellow;
Color white = Colors.white;
Color lightgrey = Colors.grey[100];

Color darkmode(click) {
  if (click) {
    Color bluegrey = Colors.blue;
    return bluegrey;
  } else {
    Color bluegrey = Colors.blueGrey;
    return bluegrey;
  }
}
