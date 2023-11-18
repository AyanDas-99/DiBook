import 'package:dibook/view/auth/constants/strings.dart';
import 'package:flutter/material.dart';

class LogoTitle extends StatelessWidget {
  const LogoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.title,
      style: const TextStyle(
        fontFamily: 'JuliusSansOne',
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
