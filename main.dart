import 'package:flutter/material.dart';
import 'package:rabu/splashScreen/my_splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DECISION SUPPORT SYSTEM FOR UCTATI STUDENT INTAKE',
      theme: ThemeData(
        primaryColor: new Color (0xFF42A5F5),
        primarySwatch: Colors.blue,

      ),
      home: MySplashScreen(),
    );
  }
}
