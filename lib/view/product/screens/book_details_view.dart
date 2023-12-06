import 'package:dibook/state/books/providers/book_by_id_provider.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/product/components/buy_and_cart_buttons.dart';
import 'package:dibook/view/product/components/description_section.dart';
import 'package:dibook/view/product/components/discount_percent.dart';
import 'package:dibook/view/product/components/image_slider.dart';
import 'package:dibook/view/product/components/price_section.dart';
import 'package:dibook/view/product/components/questions_section.dart';
import 'package:dibook/view/product/components/ratings_section.dart';
import 'package:dibook/view/product/components/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookDetailsView extends ConsumerWidget {
  const BookDetailsView(this.bookId, {super.key});
  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookByIdProvider(bookId));
    return Scaffold(
      appBar: customAppbar(context, leading: true),
      body: book.when(
        data: (book) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Heading
                RoundedContainer(child: Heading(text: book.name)),
                RoundedContainer(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StarRating(book.rating),
                )),
                const SizedBox(height: 20),

                // Images
                Stack(
                  children: [
                    ImageSlider(book.images),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: DiscountPercent(mrp: book.mrp, price: book.price),
                    )
                  ],
                ),

                const Divider(),

                // Price
                PriceSection(mrp: book.mrp, price: book.price),

                const Divider(),

                // Buttons
                BuyAndCartButtons(book.bookId),

                const Divider(),

                // Description
                DescriptionSection(book.description),

                const Divider(),

                // Ratings
                RatingsSection(book),

                const Divider(),

                // Ask Questions
                const SizedBox(height: 20),
                QuestionsSection(
                  bookId: book.bookId,
                  sellerId: book.sellerId,
                ),
              ],
            ),
          ),
        ),
        error: (e, _) => Text(e.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
