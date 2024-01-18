import 'package:dibook/state/books/models/book.dart';
import 'package:dibook/state/books/providers/books_on_sale_provider.dart';
import 'package:dibook/state/books/providers/update_book_provider.dart';
import 'package:dibook/view/auth/components/name_field.dart';
import 'package:dibook/view/components/confirm_dialog.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/new_post/components/category_field.dart';
import 'package:dibook/view/new_post/components/description_box.dart';
import 'package:dibook/view/new_post/components/stock_field.dart';
import 'package:dibook/view/new_post/strings.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditBookView extends ConsumerStatefulWidget {
  const EditBookView({super.key, required this.book});
  final Book book;

  @override
  ConsumerState<EditBookView> createState() => _EditBookViewState();
}

class _EditBookViewState extends ConsumerState<EditBookView> {
  final _formKey = GlobalKey<FormState>();

  // Values
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final categoryController = TextEditingController();
  final stockController = TextEditingController();
  void submit(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      bool? sure = await ConfirmDialog.show(
          context: context,
          content: "Are you sure you want to make these changes");
      if (sure != true) {
        return;
      }
      Book updatedBook = Book(
        widget.book.bookId,
        name: nameController.text,
        description: descController.text,
        category: categoryController.text,
        sellerId: widget.book.sellerId,
        mrp: widget.book.mrp,
        stock: int.parse(stockController.text),
        images: widget.book.images,
        rating: widget.book.rating,
        price: widget.book.price,
        frontRating: widget.book.frontRating,
        backRating: widget.book.backRating,
        markingsRating: widget.book.markingsRating,
        bindingRating: widget.book.bindingRating,
      );
      if (context.mounted) {
        bool? success = await ref
            .read(updateBookProvider.notifier)
            .updateBook(updatedBook, context);
        if (success == true) {
          ref.invalidate(booksOnSaleProvider);
        }
      }
    }
  }

  void delete(WidgetRef ref, BuildContext context) async {
    bool? sure = await ConfirmDialog.show(
        context: context,
        content:
            "Are you sure you want to delete this book? (It is irrevocable)");
    if (sure != true) {
      return;
    }
    if (context.mounted) {
      bool? deleted = await ref
          .read(updateBookProvider.notifier)
          .deleteBook(widget.book, context);

      if (deleted == true) {
        ref.invalidate(booksOnSaleProvider);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.book.name;
    descController.text = widget.book.description;
    categoryController.text = widget.book.category;
    stockController.text = widget.book.stock.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, showSearchBar: false, leading: true),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Heading(text: "Edit book details"),
                const SizedBox(height: 30),
                const Heading(
                  text: "Name",
                  sub: true,
                ),
                NameField(controller: nameController),
                const SizedBox(height: 20),
                const Heading(
                  text: "Description",
                  sub: true,
                ),
                DescriptionBox(controller: descController),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Heading(text: "Category", sub: true),
                            CategoryField(controller: categoryController),
                          ],
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Heading(text: "Stock Left", sub: true),
                          StockField(controller: stockController),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                MainButton(text: Strings.confirm, onPressed: () => submit(ref)),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 249, 198, 194),
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      const Text(
                          "Deletion of book is permanent and cannot be overridden later."),
                      const SizedBox(height: 20),
                      MainButton(
                        color: Colors.white,
                        backgroundColor: Colors.redAccent[700],
                        text: "Delete",
                        onPressed: () => delete(ref, context),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
