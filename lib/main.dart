import 'package:flutter/material.dart';
import 'package:gameku/provider/game_detail_provider.dart';
import 'package:gameku/provider/game_result_provider.dart';
import 'package:gameku/provider/screenshot_provide.dart';
import 'package:gameku/provider/video_thumbnail_provider.dart';
import 'package:gameku/ui/detail_page.dart';
import 'package:gameku/ui/home.dart';
import 'package:gameku/widgets/splash_page.dart';
import 'package:provider/provider.dart';

import 'model/api/api_service.dart';

void main() => runApp(const MyApp());

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
      ],
      child: MaterialApp(initialRoute: SplashPage.routeName, routes: {
        SplashPage.routeName: (context) => const SplashPage(),
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(
              id: int.parse(
                ModalRoute.of(context)?.settings.arguments.toString() ?? '',
              ),
              // gameDetail:
              //     ModalRoute.of(context)?.settings.arguments as GameDetail,
            )
      }),
    );
  }
}
