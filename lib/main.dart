import 'package:flutter/material.dart';
import 'package:shop_bakerclick/screens/register.dart';
import 'screens/authen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Auten(),
    );
  }
}
