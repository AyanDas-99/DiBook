import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/view/auth/screens/auth_screen_view.dart';
import 'package:dibook/view/components/title.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

PreferredSizeWidget customAppbar() => PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: AppBar(
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
                  user.name,
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
              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: const TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.search), border: InputBorder.none),
                ),
              ),
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
                    return const Text(
                      "Showing user delivery address",
                      style: TextStyle(color: Colors.white),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
