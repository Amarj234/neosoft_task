import 'dart:io';

import 'package:flutter/material.dart';

import 'package:task/features/home_screen/presantetion/home_screen.dart';
import 'package:task/main_injection.dart';

import 'main_injection.dart' as GetStorage;

void main() async{
  init();
 // await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
