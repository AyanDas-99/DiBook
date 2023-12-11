import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(this.imageProvider, {super.key});
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: imageProvider,
      loadingBuilder: (context, progress) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
              // value: _progress == null
              //     ? null
              //     : _progress.cumulativeBytesLoaded /
              //         _progress.expectedTotalBytes,
              ),
        ),
      ),
      backgroundDecoration: BoxDecoration(color: Colors.black),
      gaplessPlayback: false,
      customSize: MediaQuery.of(context).size,
      heroAttributes: const PhotoViewHeroAttributes(
        tag: "profile",
        transitionOnUserGestures: true,
      ),
      // scaleStateChangedCallback: ,
      enableRotation: true,
      // controller: controller,
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      initialScale: PhotoViewComputedScale.contained,
      basePosition: Alignment.center,
      // scaleStateCycle: scaleStateCycle,
    );
  }
}
