import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/product/screens/book_details_view.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.book});
  final Book book;

  int discount(int mrp, int price) => ((price / mrp) * 100).ceil();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => BookDetailsView(book)));
      },
      child: RoundedContainer(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: FadeInImage(
                      width: 90,
                      placeholder: const AssetImage("asset/gif/shimmer.gif"),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset("asset/images/image_error.png"),
                      image: NetworkImage(book.images[0])),
                ),
                const Spacer(),
                Text(
                  book.name.shorten(25),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red),
                      child: Text(
                        "${discount(book.mrp, book.price)}% off",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w200),
                      ),
                    ),
                    Row(
                      children: List.generate(
                          5,
                          (index) => Icon(
                                Icons.star,
                                size: 15,
                                color: (index < book.rating.floor())
                                    ? Colors.orange
                                    : Colors.grey,
                              )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
