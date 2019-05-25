import 'package:flutter/material.dart';
import './scr/first_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple SI Calculator",
    home: FirstPage(),
    theme: ThemeData(
      primaryColor: Colors.red,
      accentColor: Colors.red,

    ),
  ));
}
