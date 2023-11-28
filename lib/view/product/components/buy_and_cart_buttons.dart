import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BuyAndCartButtons extends ConsumerWidget {
  const BuyAndCartButtons(this.bookId, {super.key});
  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RoundedContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ThemeConstants.mainYellow),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(),
                ),
              ),
              child: const Text(
                "Buy Now",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 20),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ThemeConstants.lightGreen),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(),
                ),
              ),
              child: const Text(
                "Add To Cart",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
