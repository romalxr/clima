import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoadingScreen(),
        '/location': (context) => const LocationScreen(),
        '/findCity': (context) => const CityScreen(),
      },
      theme: ThemeData.dark(),
      initialRoute: '/',
      //home: const LoadingScreen(),
    );
  }
}
