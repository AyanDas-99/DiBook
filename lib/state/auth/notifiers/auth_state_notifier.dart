import 'dart:convert';

import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/auth/local_storage.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/model/user_model.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:dibook/state/utils/http_error_handler.dart';
import 'package:dibook/state/utils/show_snack_bar.dart';
import 'package:dibook/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class AuthStateNotifier extends StateNotifier<IsLoading> {
  AuthStateNotifier(this.ref) : super(false);

  final Ref ref;

  set isLoading(bool value) => {if (mounted) state = value};

  void signUpWithEmail({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    try {
      final user = User(
          name: name,
          email: email,
          password: password,
          token: '',
          id: '',
          address: '',
          photoUrl: '');

      final res = await http.post(
        Uri.parse("${Constants.baseUrl}/api/signup"),
        body: user.toJson(),
        headers: Constants.contentType,
      );
      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              signInWithEmail(
                  context: context, email: email, password: password);
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    isLoading = false;
  }

  void signInWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    try {
      final user = User(
          name: "",
          email: email,
          password: password,
          token: "",
          id: "",
          address: "",
          photoUrl: '');
      final res = await http.post(
        Uri.parse("${Constants.baseUrl}/api/signin"),
        headers: Constants.contentType,
        body: user.toJson(),
      );

      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              final response = jsonDecode(res.body);
              User user = User(
                name: response['name'],
                email: response['email'],
                token: response['token'],
                password: '',
                id: response['_id'],
                address: response['address'],
                photoUrl: response['photo_url'],
              );

              ref.read(userProvider.notifier).update((state) => user);
              LocalStorage.storeToken(response['token']);
              Navigator.of(context).pop(MaterialPageRoute(
                builder: (context) => const MainView(),
              ));
              showSnackBar(context, "Signed in");
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
    isLoading = false;
  }

  void signInWithToken(BuildContext context) async {
    try {
      final token = await LocalStorage.getToken();
      if (token == null) {
        return;
      }

      final res = await http
          .post(Uri.parse("${Constants.baseUrl}/"), headers: <String, String>{
        ...Constants.contentType,
        "x-auth-token": token,
      });
      if (context.mounted) {
        httpErrorHandler(
            context: context,
            response: res,
            onSuccess: () {
              final response = jsonDecode(res.body);
              User user = User(
                name: response['name'],
                email: response['email'],
                token: response['token'],
                password: response['password'],
                id: response['_id'],
                address: response['address'],
                photoUrl: response['photo_url'],
              );

              ref.read(userProvider.notifier).update((state) => user);
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void logout(BuildContext context) async {
    try {
      await LocalStorage.deleteToken();
      ref.read(userProvider.notifier).state = null;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
