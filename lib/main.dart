import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/pages/home-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Pokeapi',
      home: HomePage(),
    );
  }
}
