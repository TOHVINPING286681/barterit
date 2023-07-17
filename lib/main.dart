import 'package:barterit/color_schemes.g.dart';
import 'package:barterit/splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Barterit',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      home: const SplashScreen(),
    );
  }
}
