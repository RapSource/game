import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gameku/common/navigation.dart';
import 'package:gameku/data/model/game_result.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse details) async {
              final payload = details.payload;
              if (payload != null) {
                print('notification payload: $payload');
              }
              selectNotificationSubject.add(payload ?? 'empty payload');
            });
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, GameResult games) async {
      var channelId = '1';
      var channelName = 'channel_01';
      var channelDescription = 'raw game channel';

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true)
      );

      var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics
      );

      var titleNotification = '<b>Headline Games</b>';
      var titleGames = games.results[0].name;

      await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleGames, platformChannelSpecifics,
        payload: json.decode(games.toJson().toString())
      );
    }

    void configureSelectNotificationSubject(String route) {
      selectNotificationSubject.stream.listen((String payload) async {
        var data = GameResult.fromJson(json.decode(payload));
        var game = data.results[0];
        Navigation.intentWithData(route, game);
      });
    }
}
