import 'package:flutter/material.dart';
import 'package:swiftpass/screen/home_screen.dart';

void main() => runApp(const SwiftPassApp());

class SwiftPassApp extends StatelessWidget {
  const SwiftPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwiftPass',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const SwiftPassHome(),
    );
  }
}