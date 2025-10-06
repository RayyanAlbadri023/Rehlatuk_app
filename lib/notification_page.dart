// lib/notification_page.dart
import 'package:flutter/material.dart';
import 'user_data.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = userDataNotifier.value.language;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          lang == "Arabic" ? "الإشعارات" : "Notifications",
          style: TextStyle(
            color: theme.textTheme.bodyMedium?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(
          lang == "Arabic" ? "لا توجد إشعارات حتى الآن." : "No notifications yet.",
          style: TextStyle(color: theme.textTheme.bodyMedium?.color),
        ),
      ),
    );
  }
}
