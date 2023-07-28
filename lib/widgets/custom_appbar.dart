import 'package:flutter/material.dart';
import 'package:gameku/ui/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/scheduling_provider.dart';
import '../ui/about_page.dart';
import '../ui/detail_page.dart';
import '../utils/notifications_helper.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  
   @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        DetailPage.routeName);
  }
  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(
            'assets/images/mobile-game.png',
            fit: BoxFit.contain,
            height: 35,
          ),
          Container(
              margin: const EdgeInsets.only(top: 15.0, left: 5.0),
              child: Row(
                children: [
                  Text('Game',
                      style: GoogleFonts.poppins(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                  Text('KU',
                      style: GoogleFonts.poppins(
                          color: Colors.yellow, fontWeight: FontWeight.bold))
                ],
              ))
        ],
      ),
      centerTitle: true,
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<int>(
              elevation: 2,
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Setting')
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('About')
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                         return ChangeNotifierProvider<SchedulingProvider>(
                          create: (_) => SchedulingProvider(),
                          child: const SettingsPage()
                          );
                        })
                  );
                } else if (value == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const AboutPage())
                    )
                  );
                }
              },
            )),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 4, 255),
                Color.fromARGB(255, 16, 242, 223)
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
            ),
            image: DecorationImage(
                image: AssetImage('assets/images/patern.jpg'),
                opacity: 0.5,
                fit: BoxFit.none,
                repeat: ImageRepeat.repeat)),
      ),
    );
  }
}
