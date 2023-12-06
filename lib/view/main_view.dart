import 'package:dibook/view/tabs/cart/cart_view.dart';
import 'package:dibook/view/tabs/home/screens/home_view.dart';
import 'package:dibook/view/tabs/profile/profile_view.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentPage = 0;

  final items = <List>[
    ["Home", const FaIcon(FontAwesomeIcons.house), const HomeView()],
    ["Cart", const FaIcon(FontAwesomeIcons.cartShopping), const CartView()],
    [
      "Profile",
      const FaIcon(FontAwesomeIcons.userAstronaut),
      const ProfileView()
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      appBar: customAppbar(context),
      body: items[currentPage][2] as Widget,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            currentPage = value;
          });
        },
        selectedIndex: currentPage,
        destinations: items
            .map((item) => NavigationDestination(icon: item[1], label: item[0]))
            .toList(),
      ),
    );
  }
}
