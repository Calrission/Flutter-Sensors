import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUseCase {

  Function(String message) onReceiveMessage;

  NotificationUseCase(this.onReceiveMessage);

  var plugin = FlutterLocalNotificationsPlugin();

  Future<bool> requestPermission() async {
    return await plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission() ?? false;
  }

  Future<bool> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Moscow"));
    return await plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("app_icon")
      ),
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
    ) ?? false;
  }

  void pushNotification(){
    plugin.show(
      0, "test", "test",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "channel-id", "channel-name",
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.blue
        )
      ),
      payload: "test payload"
    );
  }

  void pushScheduleNotification(){
    plugin.zonedSchedule(
      0, "test", "test", tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "channel-id", "channel-name",
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.blue
        )
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime
    );
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload == null) {
      print('notification payload null: $payload');
    }else{
      onReceiveMessage(payload!);
    }
  }
}