import 'package:dibook/state/auth/providers/auth_state_provider.dart';
import 'package:dibook/view/auth/components/email_field.dart';
import 'package:dibook/view/auth/components/name_field.dart';
import 'package:dibook/view/auth/components/password_field.dart';
import 'package:dibook/view/components/title.dart';
import 'package:dibook/view/auth/constants/strings.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthScreenView extends StatelessWidget {
  AuthScreenView({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();

  final _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1.1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const LogoTitle(),
                    const Spacer(),
                    Expandable(
                      centralizeFirstChild: false,
                      backgroundColor: ThemeConstants.lightYellow,
                      boxShadow: const [],
                      firstChild: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          Strings.signUp,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      secondChild: Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            NameField(controller: nameController),
                            const SizedBox(height: 20),
                            EmailField(controller: emailController),
                            const SizedBox(height: 20),
                            PasswordField(controller: passwordController),
                            const SizedBox(height: 20),
                            Consumer(builder: (context, ref, child) {
                              return MainButton(
                                text: Strings.signUp,
                                onPressed: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    ref
                                        .read(authStateProvider.notifier)
                                        .signUpWithEmail(
                                          context: context,
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                  }
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("OR"),
                    const SizedBox(height: 20),
                    Expandable(
                      initiallyExpanded: true,
                      centralizeFirstChild: false,
                      backgroundColor: ThemeConstants.lightYellow,
                      boxShadow: const [],
                      firstChild: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          Strings.signIn,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      secondChild: Form(
                        key: _signInFormKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const SizedBox(height: 20),
                            EmailField(controller: emailController),
                            const SizedBox(height: 20),
                            PasswordField(controller: passwordController),
                            const SizedBox(height: 20),
                            Consumer(builder: (context, ref, child) {
                              return MainButton(
                                text: Strings.signIn,
                                onPressed: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    ref
                                        .read(authStateProvider.notifier)
                                        .signInWithEmail(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text);
                                  }
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("OR"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(),
                          ),
                          minimumSize: MaterialStatePropertyAll(
                              Size(double.infinity, 50))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Strings.signWithGoogle,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
