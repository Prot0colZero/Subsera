import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(VideoGeneratorApp());
}

class VideoGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Generator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}