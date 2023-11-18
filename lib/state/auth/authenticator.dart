import 'package:dibook/state/auth/constants.dart';
import 'package:http/http.dart' as http;

class Authenticator {
  void signUpWithEmail(String name, String email, String password) async {
    final res = await http.post(
      Uri.parse("${Constants.baseUrl}/api/signup"),
      headers: Constants.contentType,
      body: {
        name,
        email,
        password,
      },
    );
  }
}
