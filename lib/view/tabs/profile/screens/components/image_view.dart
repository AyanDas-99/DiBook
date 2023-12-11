import 'package:dibook/view/tabs/profile/screens/components/profile_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView(this.imageProvider, {super.key});
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).maybePop();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: ProfileImage(imageProvider)),
      ),
    );
  }
}
