import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/view/components/confirm_dialog.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/product/components/star_rating.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookCard extends ConsumerWidget {
  const BookCard(this.book, {super.key});
  final Book book;

  void delete(BuildContext context, WidgetRef ref) async {
    final confirm = await ConfirmDialog.show(
        context: context, content: "Delete this item?");

    if (confirm == true) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RoundedContainer(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage(
                width: 90,
                placeholder: const AssetImage("asset/gif/shimmer.gif"),
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
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
                    Text(
                      book.name.shorten(25),
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
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
                        Text(
                          book.stock.toString(),
                        ),
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
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      color: ThemeConstants.lightGreen,
                      child: IconButton(
                        color: ThemeConstants.darkGreen,
                        icon: const Icon(
                          size: 15,
                          FontAwesomeIcons.pen,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 30,
                      height: 30,
                      color: ThemeConstants.mainYellow,
                      child: IconButton(
                        color: ThemeConstants.darkGreen,
                        icon: const Icon(
                          size: 15,
                          FontAwesomeIcons.trash,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
