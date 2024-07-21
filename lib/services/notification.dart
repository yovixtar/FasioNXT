import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/launcher_icon"));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  static Future<void> display(String title, String body) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "Channel Id",
          "Main Channel",
          groupKey: "NusantaraDelight",
          importance: Importance.max,
          playSound: true,
          priority: Priority.high,
        ),
      );
      await _notificationsPlugin.show(id, title, body, notificationDetails,
          payload: '');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
