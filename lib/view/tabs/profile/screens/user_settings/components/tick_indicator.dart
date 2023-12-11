import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TickIndicator extends StatelessWidget {
  const TickIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
          padding: const EdgeInsets.all(8),
          color: ThemeConstants.darkGreen,
          child: const FaIcon(
            FontAwesomeIcons.check,
            color: Colors.white,
            size: 15,
          )),
    );
  }
}
