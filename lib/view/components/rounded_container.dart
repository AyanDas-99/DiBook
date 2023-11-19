import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget? child;
  const RoundedContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: child,
    );
  }
}
