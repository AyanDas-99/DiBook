import 'package:dibook/state/book_upload/providers/book_upload_notifier_provider.dart';
import 'package:dibook/state/books/models/book_payload.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/main_view.dart';
import 'package:dibook/view/new_post/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewBookConfirmationView extends StatelessWidget {
  const NewBookConfirmationView({super.key, required this.book});
  final BookPayload book;

  void confirm(WidgetRef ref, BuildContext context) async {
    final uploaded = await ref
        .read(bookUploadNotifierProvider.notifier)
        .uploadBook(context, book);
    print(uploaded);
    if (uploaded) {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MainView(),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(showSearchBar: false),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.forEach,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Heading(text: "Rs. ${book.price}"),
                    const SizedBox(height: 30),
                    Text(
                      book.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${book.stock} books in stock",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 0.5,
                          color: Colors.grey,
                        )),
                        child: Text(Strings.thePriceOf),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Consumer(builder: (context, ref, child) {
              return MainButton(
                  text: Strings.confirm,
                  onPressed: () => confirm(ref, context));
            }),
            const SizedBox(height: 30),
            MainButton(
                backgroundColor: Colors.red,
                color: Colors.white,
                text: Strings.cancel,
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
