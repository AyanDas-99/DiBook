import 'package:carousel_slider/carousel_slider.dart';
import 'package:dibook/view/tabs/profile/screens/components/image_view.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider(this.images, {super.key});
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index, int realIndex) => InkWell(
        onTap: () {
          // Show image on top
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ImageView(NetworkImage(images[index]))));
        },
        child: FadeInImage(
          height: 300,
          placeholder: const AssetImage("asset/gif/shimmer.gif"),
          imageErrorBuilder: (context, error, stackTrace) =>
              Image.asset("asset/images/image_error.png"),
          image: NetworkImage(images[index]),
        ),
      ),
      options: CarouselOptions(),
    );
  }
}
