import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/state/order/providers/order_notifier_provider.dart';
import 'package:dibook/view/components/confirm_dialog.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/components/text_and_icon.dart';
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
      child: Stack(
        children: [
          RoundedContainer(
            child: Padding(
              padding: const EdgeInsets.all(5),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.name.shorten(25),
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              "Id: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              book.bookId,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
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
                        SizedBox(
                          width: 100,
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: ThemeConstants.mainYellow)),
                            )),
                            child: const TextAndIcon(
                              text: "Edit",
                              iconSize: 15,
                              color: Colors.black,
                              icon: FontAwesomeIcons.pen,
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.grey.shade100)),
              color: Colors.black54,
              padding: const EdgeInsets.all(5),
              icon: const FaIcon(
                FontAwesomeIcons.trash,
                size: 15,
              ),
              onPressed: () => delete(context, ref),
            ),
          ),
        ],
      ),
    );
  }
}
