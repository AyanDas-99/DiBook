import 'package:flutter/material.dart';

class ThemeConstants {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: lightYellow,
    appBarTheme:
        const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: MaterialStatePropertyAll(
        IconThemeData(color: darkGreen, size: 20),
      ),
      indicatorColor: Colors.transparent,
    ),
  );

  static Color darkGreen = const Color.fromRGBO(101, 131, 97, 1);
  static Color lightGreen = const Color.fromRGBO(208, 221, 151, 1);
  static Color lightYellow = const Color.fromRGBO(248, 250, 228, 1);
  static Color mainYellow = const Color.fromRGBO(249, 222, 121, 1);

  static LinearGradient appbarGradient = LinearGradient(
      colors: [darkGreen, lightGreen],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);

  const ThemeConstants._();
}
