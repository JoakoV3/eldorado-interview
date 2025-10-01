import 'package:flutter/material.dart';
import 'package:interview/presentation/home_page.dart';
import 'package:interview/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: HomePage(),
    );
  }
}
