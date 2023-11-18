import 'package:dibook/view/components/defaultTextField.dart';
import 'package:dibook/view/components/title.dart';
import 'package:dibook/view/auth/constants/strings.dart';
import 'package:dibook/view/components/MainButton.dart';
import 'package:dibook/view/theme/ThemeConstants.dart';
import 'package:flutter/material.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    const SizedBox(height: 20),
                    const LogoTitle(),
                    Spacer(),
                    Expandable(
                      centralizeFirstChild: false,
                      backgroundColor: ThemeConstants.lightYellow,
                      boxShadow: [],
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
                      secondChild: Column(
                        children: [
                          const SizedBox(height: 20),
                          DefaultTextField(
                            controller: nameController,
                            placeHolder: Strings.name,
                          ),
                          const SizedBox(height: 20),
                          DefaultTextField(
                            controller: emailController,
                            placeHolder: Strings.email,
                          ),
                          const SizedBox(height: 20),
                          DefaultTextField(
                            controller: passwordController,
                            placeHolder: Strings.password,
                          ),
                          const SizedBox(height: 20),
                          MainButton(
                            text: Strings.signUp,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("OR"),
                    const SizedBox(height: 20),
                    Expandable(
                      initiallyExpanded: true,
                      centralizeFirstChild: false,
                      backgroundColor: ThemeConstants.lightYellow,
                      boxShadow: [],
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
                      secondChild: Column(
                        children: [
                          const SizedBox(height: 20),
                          const SizedBox(height: 20),
                          DefaultTextField(
                            controller: emailController,
                            placeHolder: Strings.email,
                          ),
                          const SizedBox(height: 20),
                          DefaultTextField(
                            controller: passwordController,
                            placeHolder: Strings.password,
                          ),
                          const SizedBox(height: 20),
                          MainButton(
                            text: Strings.signIn,
                            onPressed: () {},
                          ),
                        ],
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
                            Strings.SignWithGoogle,
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
                    const Spacer(),
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
