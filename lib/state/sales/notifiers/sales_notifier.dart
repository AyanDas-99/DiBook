import 'package:dibook/state/auth/constants.dart';
import 'package:dibook/state/order/models/order.dart';
import 'package:dibook/state/typedefs/is_loading.dart';
import 'package:dibook/state/user/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class SalesNotifier extends StateNotifier<IsLoading> {
  SalesNotifier(this.ref) : super(false);

  final Ref ref;

  set isLoading(bool value) => {if (mounted) state = value};

  void addNewSale(List<Order> orders) async {
    try {
      final user = ref.watch(userProvider);
      for (var order in orders) {
        await http.post(Uri.parse("${Constants.baseUrl}/sales/create-sale"),
            headers: {
              ...Constants.contentType,
              "x-auth-token": user!.token,
            },
            body: order.toJson());
      }
    } catch (e) {
      print(e);
    }
  }
}
