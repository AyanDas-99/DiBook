import 'package:dibook/state/books/providers/book_by_id_provider.dart';
import 'package:dibook/state/cart/models/cart_item.dart';
import 'package:dibook/state/cart/providers/update_cart_notifier_provider.dart';
import 'package:dibook/view/components/confirm_dialog.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/components/shimmer_container.dart';
import 'package:dibook/view/product/components/star_rating.dart';
import 'package:dibook/view/product/screens/book_details_view.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartItemView extends ConsumerWidget {
  const CartItemView(this.item, {super.key});
  final CartItem item;

  void delete(BuildContext context, WidgetRef ref, String bookName) async {
    final confirm = await ConfirmDialog.show(
        context: context,
        content: '''You are deleting this item from cart\n\n- $bookName''');

    if (confirm == true && context.mounted) {
      ref
          .read(updateCartNotifierProvider.notifier)
          .deleteFromCart(context: context, bookId: item.bookId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookByIdProvider(item.bookId));

    return book.when(
        data: (book) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                RoundedContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeInImage(
                          width: 90,
                          placeholder:
                              const AssetImage("asset/gif/shimmer.gif"),
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            "asset/images/image_error.png",
                            width: 100,
                          ),
                          image: NetworkImage(book.images[0]),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          BookDetailsView(book.bookId)));
                                },
                                child: Text(
                                  book.name.shorten(25),
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 30),
                              StarRating(book.rating),
                              const SizedBox(height: 10),

                              // Books sold

                              Text(
                                "Rs. ${book.price}",
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "MRP. Rs. ${book.mrp}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 13,
                                    decoration: TextDecoration.lineThrough),
                              ),

                              // If none available
                              if (book.stock == 0)
                                const Text(
                                  "Not available",
                                  style: TextStyle(color: Colors.red),
                                ),

                              // If less available than required
                              if (book.stock != 0 && book.stock < item.quantity)
                                Text(
                                  "Only ${book.stock} available in stock",
                                  style: const TextStyle(color: Colors.red),
                                ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const Flexible(
                          child: FaIcon(
                            FontAwesomeIcons.x,
                            size: 15,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Increase the quantity if possible
                                  ref
                                      .read(updateCartNotifierProvider.notifier)
                                      .addToCart(
                                          context: context,
                                          bookId: item.bookId);
                                },
                                icon: const FaIcon(FontAwesomeIcons.caretUp),
                              ),
                              Text("${item.quantity}"),
                              IconButton(
                                onPressed: () {
                                  // Decrease the quantity if possible
                                  ref
                                      .read(updateCartNotifierProvider.notifier)
                                      .removeFromCart(
                                          context: context,
                                          bookId: item.bookId);
                                },
                                icon: const FaIcon(FontAwesomeIcons.caretDown),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    width: 30,
                    height: 30,
                    color: ThemeConstants.mainYellow,
                    child: IconButton(
                      color: ThemeConstants.darkGreen,
                      icon: const Icon(
                        size: 15,
                        FontAwesomeIcons.trash,
                      ),
                      onPressed: () => delete(context, ref, book.name),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (e, _) => Text(e.toString()),
        loading: () => ShimmerContainer(context));
  }
}
