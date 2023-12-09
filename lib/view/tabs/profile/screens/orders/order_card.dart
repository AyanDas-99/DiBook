import 'package:dibook/state/books/providers/book_by_id_provider.dart';
import 'package:dibook/state/order/models/order.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/components/shimmer_container.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookByIdProvider(order.bookId));
    return book.when(
      data: (book) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: RoundedContainer(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                FadeInImage(
                  width: 90,
                  placeholder: const AssetImage("asset/gif/shimmer.gif"),
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset("asset/images/image_error.png"),
                  image: NetworkImage(book.images[0]),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Heading(
                        text: book.name.shorten(25),
                        sub: true,
                      ),
                      const SizedBox(height: 15),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs. ${book.price}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "x",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${order.quantity}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "=",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rs. ${book.price * order.quantity}",
                              style: TextStyle(
                                  color: ThemeConstants.darkGreen,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 100,
                        child: MainButton(
                            text: "Cancel",
                            backgroundColor: Colors.transparent,
                            onPressed: () {}),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      error: (e, _) => Text(e.toString()),
      loading: () => ShimmerContainer(context),
    );
  }
}
