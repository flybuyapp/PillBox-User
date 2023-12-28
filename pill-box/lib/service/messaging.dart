import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/service/helpers/request_helper.dart';
import 'package:flybuy/utils/debug.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/firebase_options.dart' as firebase_config;

SharedPreferences? sharedPref;

Future<SharedPreferences> getSharedPref() async {
  sharedPref ??= await SharedPreferences.getInstance();
  if (!isWeb) {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    await sharedPref?.setString('appDocDir', appDocDir.path);
  }
  return sharedPref!;
}

/// Init Firebase service
Future<void> initializePushNotificationService() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: firebase_config.apiKey,
        appId: firebase_config.appId,
        messagingSenderId: firebase_config.messagingSenderId,
        projectId: firebase_config.projectId,
      ),
    );
  } else {
    //OneSignal.shared.setAppId("c9a1a3ad-3e79-4a83-9589-042cd43081cc");
    await Firebase.initializeApp();
  }

  /// Subscribe to default topic
  subscribeTopic(topic: kIsWeb ? 'web' : Platform.operatingSystem);
}

/// Update token to database
Future<void> updateTokenToDatabase(
  RequestHelper requestHelper,
  String? token, {
  List<String>? topics,
  String? userId,
  String? email,
}) async {
  try {
    if (topics != null) {
      await subscribeTopic(topic: topics, userId: userId, email: email);
    }
  } catch (e) {
    avoidPrint(
        '=========> Warning: Plugin Push Notifications Mobile And Web App Not Installed. Download here: https://wordpress.org/plugins/push-notification-mobile-and-web-app');
  }
}

/// Remove user token database
Future<void> removeTokenInDatabase(
  RequestHelper requestHelper,
  String? token,
  String? userId, {
  List<String>? topics,
}) async {
  try {
    if (topics != null) {
      await unSubscribeTopic(topic: topics);
    }
  } catch (e) {
    avoidPrint(
        '=========> Warning: Plugin Push Notifications Mobile And Web App Not Installed. Download here: https://wordpress.org/plugins/push-notification-mobile-and-web-app');
  }
}

/// Get token
Future<String?> getToken() async {
  return null;
}

/// Subscribing to topics
Future<void> subscribeTopic(
    {dynamic topic, String? userId, String? email}) async {
  if (kIsWeb) return;
  if (topic is String) {
    //OneSignal.shared.sendTag("topic", topic);
  }
  if (topic is List<String>) {
    Map<String, String> dataRoles = {};
    for (var item in topic) {
      dataRoles.putIfAbsent(item, () => "1");
    }
    //OneSignal.shared.sendTags({"user_id": userId, "email": email, ...dataRoles});
  }
}

/// Un subscribing to topics
Future<void> unSubscribeTopic({dynamic topic}) async {
  if (kIsWeb) return;
  if (topic is List<String>) {
    //OneSignal.shared.deleteTags(["user_id", "email", ...topic]);
    avoidPrint("Un subscribing to topics $topic");
  }
}

/// Listening the changes
mixin MessagingMixin<T extends StatefulWidget> on State<T> {
  Future<void> subscribe(RequestHelper requestHelper, Function navigate) async {
    /*OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      Map<String, dynamic>? additionalData =
          openedResult.notification.additionalData;
      Map<String, dynamic> data = {
        'type': additionalData!['type'],
        'route': additionalData['route'],
        'args': jsonDecode(additionalData['args'])
      };
      navigate(data);
    });*/
  }
}
