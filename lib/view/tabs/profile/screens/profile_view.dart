import 'package:dibook/state/auth/providers/auth_state_provider.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/view/auth/screens/auth_screen_view.dart';
import 'package:dibook/view/components/confirm_dialog.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/new_post/screens/add_new_book_view.dart';
import 'package:dibook/view/tabs/profile/screens/books_on_sale/books_on_sale_view.dart';
import 'package:dibook/view/tabs/profile/screens/orders/orders_view.dart';
import 'package:dibook/view/tabs/profile/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  void logout(BuildContext context, WidgetRef ref) async {
    final confirm = await ConfirmDialog.show(
        context: context, content: "Are you sure you want to log out?");
    if (confirm == true) {
      if (context.mounted) {
        ref.read(authStateProvider.notifier).logout(context);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    if (user == null) {
      return Column(
        children: [
          MainButton(
              text: Constants.logIn,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthScreenView(),
                    ));
              })
        ],
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Heading(text: Constants.profile)),
              const CircleAvatar(
                radius: 50,
              ),
              const SizedBox(height: 20),
              Text(
                user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              Text(user.email),
              const SizedBox(height: 30),
              RoundedContainer(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OrderView(),
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Constants.orders),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddNewBookView(),
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Constants.sellABook),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BooksOnSaleView(),
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Constants.booksOnSale),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Constants.earnings),
                          const Icon(Icons.arrow_right)
                        ],
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () => logout(context, ref),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Constants.logout),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                    ],
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
