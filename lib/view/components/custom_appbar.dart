import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/view/auth/screens/auth_screen_view.dart';
import 'package:dibook/view/components/title.dart';
import 'package:dibook/view/searched_books/searched_books_view.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:dibook/view/utils/string_shortener.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

PreferredSizeWidget customAppbar(BuildContext context,
    {bool showSearchBar = true,
    bool leading = false,
    Widget? leadingWidget,
    bool showAddress = true}) {
  final searchController = TextEditingController();

  return PreferredSize(
    preferredSize: Size.fromHeight(showSearchBar
        ? 170
        : showAddress
            ? 100
            : 60),
    child: AppBar(
      automaticallyImplyLeading: leading,
      leading: leadingWidget,
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: ThemeConstants.appbarGradient),
      ),
      title: const LogoTitle(
        size: 30,
        weight: FontWeight.normal,
        color: Colors.white,
      ),
      actions: [
        Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(userProvider);
            if (user == null) {
              return InkWell(
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AuthScreenView()));
                },
              );
            } else {
              return Text(
                user.name.shorten(20),
                style: const TextStyle(color: Colors.white),
              );
            }
          },
        ),
        IconButton(
            onPressed: () {
              // Bell icon
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ))
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Column(
          children: [
            if (showSearchBar)
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.search), border: InputBorder.none),
                  onSubmitted: (value) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchedBooksView(
                            searchQuery: searchController.text)));
                  },
                ),
              ),

            // Address bar
            if (showAddress)
              Container(
                width: double.infinity,
                color: ThemeConstants.darkGreen,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer(builder: (context, ref, child) {
                    final user = ref.watch(userProvider);
                    if (user == null) {
                      return const Text(
                        "Login to pick a delivery address",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    if (user.address.isEmpty) {
                      return const Text(
                        "Add delivery address in the profile settings",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    return Text(
                      user.address.shorten(40),
                      style: const TextStyle(color: Colors.white),
                    );
                  }),
                ),
              )
          ],
        ),
      ),
    ),
  );
}
