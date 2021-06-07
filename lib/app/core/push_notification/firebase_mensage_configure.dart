import 'dart:convert';
import 'dart:io';

import 'package:cuida_pet/app/models/chat_model.dart';
import 'package:cuida_pet/app/modules/chat_lista/chat/chat_controller.dart';
import 'package:cuida_pet/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FirebaseMensageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> configure() async {
    final initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'br.com.bilangieri.cuida_pet', 'cuida_pet', 'Cuida Pet',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    final iOsPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOsPlatformChannelSpecifics);

    if (Platform.isIOS) {
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (message) async {
        print('onMessage: $message');

        String payload;

        if (Platform.isIOS) {
          payload = message['payload'];
        } else {
          payload = message['data']['payload'];
        }
        var showMessage = true;

        try {
          final payloadData = json.decode(payload);
          if (payloadData['type'] == 'CHAT_MESSAGE') {
            var chatController = Modular.get<ChatController>();
            if (chatController.chat.id == payloadData['chat']['id']) {
              showMessage = false;
            }
          }
        } on ModularError {
          showMessage = true;
        }
        if (showMessage) {
          await _flutterLocalNotificationsPlugin.show(
            99,
            message['notification']['title'],
            message['notification']['body'],
            platformChannelSpecifics,
            payload: payload,
          );
        }
      },
      onLaunch: (message) async {
        print('onMessage: $message');
      },
      onResume: (message) async {
        print('onMessage: $message');
      },
    );

    String deviceId = await _fcm.getToken();
    print(deviceId);
    final prefs = await SharedPrefsRepository.instance;
    prefs.registerDeviceId(deviceId);
  }

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    print(title);
  }

  Future _onSelectNotification(String payload) {
    var chatController;
    if (payload != null) {
      final data = json.decode(payload);
      if (data['type'] == 'CHAT_MESSAGE') {
        final model = ChatModel.fromJson(data['chat']);
        bool abrirChat = true;
        try {
          chatController = Modular.get<ChatController>();
          if (chatController.chat.id == model.id) {
            abrirChat = false;
          }
        } on ModularError {
          abrirChat = true;
        }
        if (abrirChat) {
          Modular.to.pushNamed('chatLista/chat', arguments: model);
        }
      } else if (data['type'] == 'AU') {}
      Modular.to.pushNamed('meusagendamentos');
    }
  }
}
