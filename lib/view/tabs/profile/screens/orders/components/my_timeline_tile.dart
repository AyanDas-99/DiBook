import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
  const MyTimelineTile({
    super.key,
    this.first = false,
    this.last = false,
    this.done = false,
    required this.title,
    this.image,
  });
  final bool first;
  final bool last;
  final String? image;
  final bool done;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TimelineTile(
        alignment: TimelineAlign.start,
        endChild: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            title,
            style: TextStyle(color: done ? Colors.black : Colors.grey),
          ),
        ),
        isFirst: first,
        isLast: last,
        beforeLineStyle: done
            ? const LineStyle(color: Colors.green, thickness: 7)
            : const LineStyle(),
        afterLineStyle: done
            ? const LineStyle(color: Colors.green, thickness: 7)
            : const LineStyle(),
        indicatorStyle: IndicatorStyle(
          width: 50,
          height: 50,
          indicator: (image == null)
              ? Container(
                  padding: const EdgeInsets.all(10),
                  child: const CircleAvatar(),
                )
              : CircleAvatar(
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        image!,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
