import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gameku/common/navigation.dart';
import 'package:gameku/provider/game_detail_provider.dart';
import 'package:gameku/provider/game_result_provider.dart';
import 'package:gameku/provider/preferences_provider.dart';
import 'package:gameku/provider/scheduling_provider.dart';
import 'package:gameku/ui/detail_page.dart';
import 'package:gameku/ui/home.dart';
import 'package:gameku/utils/background_service.dart';
import 'package:gameku/utils/notifications_helper.dart';
import 'package:gameku/widgets/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/api/api_service.dart';
import 'model/data/preferences/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameProvider>(
            create: (_) => GameProvider(apiService: ApiService())),
        ChangeNotifierProvider<GameDetailProvider>(
            create: (_) => GameDetailProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                  preferencesHelper: PreferencesHelper(
                      sharedPreferences: SharedPreferences.getInstance()),
                )),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                    brightness: provider.isDarkTheme
                        ? Brightness.dark
                        : Brightness.light),
                child: Material(child: child),
              );
            },
            navigatorKey: navigatorKey,
            initialRoute: SplashPage.routeName,
            routes: {
              SplashPage.routeName: (context) => const SplashPage(),
              HomePage.routeName: (context) => const HomePage(),
              DetailPage.routeName: (context) => DetailPage(
                    id: int.parse(
                      ModalRoute.of(context)?.settings.arguments.toString() ??
                          '',
                    ),
                    // gameDetail:
                    //     ModalRoute.of(context)?.settings.arguments as GameDetail,
                  )
            });
      }),
    );
  }
}
