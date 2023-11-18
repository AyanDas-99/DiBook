import 'package:dibook/view/auth/screens/auth_screen.dart';
import 'package:dibook/view/theme/ThemeConstants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeConstants.themeData,
      home: AuthScreen(),
    );
  }
}
