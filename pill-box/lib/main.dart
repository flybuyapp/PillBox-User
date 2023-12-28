import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'service/service.dart';

late AppService appServiceInject;

/// App starts
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePushNotificationService();
  SharedPreferences sharedPref = await getSharedPref();

  appServiceInject = await AppServiceInject.create(
    PreferenceModule(sharedPref: sharedPref),
    NetworkModule(),
  );

  runApp(appServiceInject.getApp);
  final dir = (await getApplicationDocumentsDirectory()).path;
  File('$dir/data.json').writeAsStringSync('');
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      locked: true,
      channelKey: 'pill_channel',
      channelName: 'Pill Reminder',
      defaultColor: const Color(0xffCC197D),
      importance: NotificationImportance.High,
      channelShowBadge: true,
      channelDescription: 'Description',
    ),
  ]);
  await AwesomeNotifications().requestPermissionToSendNotifications();
}
