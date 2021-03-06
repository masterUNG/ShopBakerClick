import 'package:flutter/material.dart';

class MyStyle {

  Color mainColor = Colors.green.shade700;
  Color wakeColor = Colors.green.shade200;
  Color appBarColor = Colors.orange.shade700;


  TextStyle h2MainTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.blue.shade800,
  );

  TextStyle h2WeakTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.yellow.shade300,
  );

  TextStyle h1TextStyle = TextStyle(
    fontSize: 30.0,
    fontStyle: FontStyle.italic,
    color: Colors.pink,
  );

  MyStyle();
}
