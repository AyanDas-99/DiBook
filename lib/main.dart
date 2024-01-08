import 'package:dibook/state/auth/providers/auth_state_provider.dart';
import 'package:dibook/state/providers/is_loading.dart';
import 'package:dibook/view/components/overlay_loading.dart';
import 'package:dibook/view/main_view.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(authStateProvider.notifier).signInWithToken(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeConstants.themeData,
      home: Consumer(
        builder: (context, ref, child) {
          // Showing loading
          ref.listen(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              OverlayLoading.instance().showLoading(context);
            } else {
              OverlayLoading.instance().hide();
            }
          });

          return const MainView();
        },
      ),
    );
  }
}
