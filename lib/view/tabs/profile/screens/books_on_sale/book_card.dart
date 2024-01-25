import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/state/sales/providers/sale_by_book_id_provider.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/product/components/star_rating.dart';
import 'package:dibook/view/product/screens/book_details_view.dart';
import 'package:dibook/view/tabs/profile/screens/books_on_sale/edit_book_view.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookCard extends ConsumerWidget {
  const BookCard(this.book, {super.key});
  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sold = ref.watch(saleByBookIdProvider(book.bookId));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RoundedContainer(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInImage(
                    width: 90,
                    placeholder: const AssetImage("asset/gif/shimmer.gif"),
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                      "asset/images/image_error.png",
                      width: 100,
                    ),
                    image: NetworkImage(book.images[0]),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    flex: 2,
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
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        StarRating(book.rating),
                        const SizedBox(height: 10),

                        // Books sold

                        Row(
                          children: [
                            const Text(
                              "Sold: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            sold.when(
                                data: (sold) => Text(
                                      sold.toString(),
                                    ),
                                error: (e, st) => Row(
                                      children: [
                                        Text(e.toString()),
                                        IconButton(
                                            onPressed: () => ref.invalidate(
                                                saleByBookIdProvider),
                                            icon: const FaIcon(
                                              FontAwesomeIcons.rotateLeft,
                                              size: 15,
                                            )),
                                      ],
                                    ),
                                loading: () =>
                                    const CircularProgressIndicator()),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Stock left: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              book.stock.toString(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        border: Border.all(
                            color: ThemeConstants.darkGreen, width: 0.5),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1,
                          )
                        ]),
                    // Edit book
                    child: IconButton(
                      color: ThemeConstants.darkGreen,
                      icon: const Icon(
                        size: 15,
                        FontAwesomeIcons.penToSquare,
                      ),
                      onPressed: () {
                        // Edit
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditBookView(book: book)));
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
