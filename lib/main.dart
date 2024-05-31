import 'package:camera_app/dbapp.dart';
import 'package:camera_app/splashscreen.dart';
import 'package:flutter/material.dart';

void main() async {
  await Hivehelper.openImageBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        title: 'Camera App',
        home: const ScreenSplash());
  }
  
}
