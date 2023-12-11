import 'package:dibook/state/auth/providers/auth_state_provider.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/view/auth/screens/auth_screen_view.dart';
import 'package:dibook/view/components/confirm_dialog.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/components/rounded_container.dart';
import 'package:dibook/view/components/text_and_icon.dart';
import 'package:dibook/view/new_post/screens/add_new_book_view.dart';
import 'package:dibook/view/tabs/profile/screens/books_on_sale/books_on_sale_view.dart';
import 'package:dibook/view/tabs/profile/screens/components/image_view.dart';
import 'package:dibook/view/tabs/profile/screens/orders/orders_view.dart';
import 'package:dibook/view/tabs/profile/constants.dart';
import 'package:dibook/view/tabs/profile/screens/user_settings/user_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              InkWell(
                onTap: () {
                  // Show image on top
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImageView(NetworkImage(user.photoUrl))));
                },
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(60),
                    child: Hero(
                      tag: "profile",
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: const AssetImage("asset/gif/shimmer.gif"),
                        image: NetworkImage(user.photoUrl),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset("asset/images/image_error.png"),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox.fromSize(
              //     size: Size.fromRadius(60),
              //     child: ProfileImage(NetworkImage(user.photoUrl))),

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
                            TextAndIcon(
                              text: Constants.orders,
                              icon: FontAwesomeIcons.truckFast,
                              iconSize: 15,
                              reversed: true,
                              space: 20,
                            ),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                      const Divider(height: 30),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddNewBookView(),
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextAndIcon(
                              text: Constants.sellABook,
                              icon: FontAwesomeIcons.moneyCheckDollar,
                              iconSize: 15,
                              reversed: true,
                              space: 20,
                            ),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                      const Divider(height: 30),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BooksOnSaleView(),
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextAndIcon(
                              text: Constants.booksOnSale,
                              icon: FontAwesomeIcons.bookAtlas,
                              iconSize: 15,
                              reversed: true,
                              space: 20,
                            ),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextAndIcon(
                            text: Constants.earnings,
                            icon: FontAwesomeIcons.piggyBank,
                            iconSize: 15,
                            reversed: true,
                            space: 20,
                          ),
                          const Icon(Icons.arrow_right)
                        ],
                      ),
                      const Divider(height: 30),
                      InkWell(
                        onTap: () => logout(context, ref),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextAndIcon(
                              text: Constants.logout,
                              icon: FontAwesomeIcons.arrowUpFromBracket,
                              iconSize: 15,
                              reversed: true,
                              space: 20,
                            ),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                      const Divider(height: 30),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const UserSettingsView()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextAndIcon(
                              text: Constants.userSettings,
                              icon: FontAwesomeIcons.penClip,
                              iconSize: 15,
                              reversed: true,
                              space: 20,
                            ),
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
