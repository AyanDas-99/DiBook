import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';

class SingleBook extends StatelessWidget {
  const SingleBook(this.book, {super.key});
  final Book book;

  int discount(int mrp, int price) => 100 - ((price / mrp) * 100).ceil();

  @override
  Widget build(BuildContext context) {
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
                        Heading(text: book.name.shorten(45)),
                        const SizedBox(height: 15),
                        Row(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    size: 20,
                                    color: (index < book.rating.floor())
                                        ? Colors.orange
                                        : Colors.grey,
                                  )),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Heading(
                              text: "Rs. ${book.price}",
                              sub: true,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "MRP Rs. ${book.mrp}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.red),
              child: Text(
                "${discount(book.mrp, book.price)}% off",
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
