import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  final bool sub;
  final Color? color;
  const Heading({super.key, required this.text, this.sub = false, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
        fontSize: 18,
        fontWeight: sub ? FontWeight.w500 : FontWeight.w700,
        color: color,
      ),
    );
  }
}
