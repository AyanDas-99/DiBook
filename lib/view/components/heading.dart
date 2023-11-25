import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  final bool sub;
  const Heading({super.key, required this.text, this.sub = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: sub ? FontWeight.w500 : FontWeight.w700,
      ),
    );
  }
}
