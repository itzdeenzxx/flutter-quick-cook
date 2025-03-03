import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(const QuickCookApp());

class QuickCookApp extends StatelessWidget {
  const QuickCookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickCook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSansThai',
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}