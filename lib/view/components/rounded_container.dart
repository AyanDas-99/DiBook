import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  const RoundedContainer({super.key, this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: child,
    );
  }
}
