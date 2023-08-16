import 'package:flutter/material.dart';
import 'package:gameku/widgets/popup_menu_item.dart';
import 'package:google_fonts/google_fonts.dart';

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
                          color: const Color.fromARGB(255, 139, 139, 139), fontWeight: FontWeight.bold)),
                  Text('KU',
                      style: GoogleFonts.poppins(
                          color: Colors.yellow, fontWeight: FontWeight.bold))
                ],
              ))
        ],
      ),
      centerTitle: true,
      actions: const <Widget>[
        Padding(
            padding: EdgeInsets.all(8.0),
            child: PopupMenu()
          ),
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
