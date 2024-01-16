import 'package:dibook/state/books/providers/book_by_id_provider.dart';
import 'package:dibook/state/order/models/order.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/components/shimmer_container.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/services.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookByIdProvider(order.bookId));
    return book.when(
      data: (book) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: double.infinity,
                color: Colors.blueGrey[50],
                child: Text(
                    "Ordered on ${order.createdAt.day} / ${order.createdAt.month} / ${order.createdAt.year}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            width: 80,
                            placeholder:
                                const AssetImage("asset/gif/shimmer.gif"),
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset("asset/images/image_error.png"),
                            image: NetworkImage(book.images[0]),
                          ),
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
                                constraints:
                                    const BoxConstraints(maxWidth: 250),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rs. ${book.price}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "x",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${order.quantity}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "=",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
                                    color: Colors.red,
                                    onPressed: () {}),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Order id
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'Order Id: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: order.orderId,
                                  style: const TextStyle(color: Colors.black))
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: order.orderId));
                              if (context.mounted) {
                                showSnackBar(context, 'Copied to clipboard');
                              }
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.copy,
                              size: 18,
                            ))
                      ],
                    ),

                    //
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      error: (e, _) => Text(e.toString()),
      loading: () => ShimmerContainer(context),
    );
  }
}
