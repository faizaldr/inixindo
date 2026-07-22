import 'package:flutter/material.dart';
import 'package:inixindo/modules/auth/pages/login.dart';
import 'package:inixindo/modules/location/pages/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: LocationPage(),
   );
  }
}