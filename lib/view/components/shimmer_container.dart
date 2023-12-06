import 'package:flutter/material.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer(this.parent, {super.key, this.width});
  final BuildContext parent;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(parent).size.width,
      height: 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            "asset/gif/shimmer.gif",
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: (width != null)
                      ? width! * 0.5
                      : MediaQuery.of(parent).size.width * 0.5,
                  height: 30,
                  child: Image.asset(
                    "asset/gif/shimmer.gif",
                    fit: BoxFit.fitWidth,
                  )),
              SizedBox(
                  width: (width != null)
                      ? width! * 0.5
                      : MediaQuery.of(parent).size.width * 0.5,
                  height: 30,
                  child: Image.asset(
                    "asset/gif/shimmer.gif",
                    fit: BoxFit.fitWidth,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
