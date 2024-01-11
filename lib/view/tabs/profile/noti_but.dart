import 'package:dibook/state/utils/local_notifications.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiBut extends StatelessWidget {
  const NotiBut({super.key});

  @override
  Widget build(BuildContext context) {
    return MainButton(
      text: "Send notification",
      onPressed: () {
        LocalNotifications.showSimpleNotification(
            title: "Simple notification",
            body: "Hello world! This is me..",
            payload:
                "What a wonder full app this is. I can't believe this can possibly exist in our world.");
      },
    );
  }
}
