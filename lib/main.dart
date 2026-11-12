import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SparkPointApp());
}

class SparkPointApp extends StatelessWidget {
  const SparkPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spark Point',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.oscuro,
      home: const Scaffold(
        body: Center(
          child: Text('Spark Point'),
        ),
      ),
    );
  }
}