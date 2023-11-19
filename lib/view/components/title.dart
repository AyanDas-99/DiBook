import 'package:dibook/view/auth/constants/strings.dart';
import 'package:flutter/material.dart';

class LogoTitle extends StatelessWidget {
  final double? size;
  final FontWeight? weight;
  final Color? color;
  const LogoTitle(
      {super.key, this.size = 40, this.weight = FontWeight.bold, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.title,
      style: TextStyle(
        fontFamily: 'JuliusSansOne',
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}
