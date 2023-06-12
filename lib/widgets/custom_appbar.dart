import 'package:flutter/material.dart';
import 'package:gameku/ui/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/mobile-game.png',
            fit: BoxFit.contain,
            height: 35,
          ),
          Container(
              margin: const EdgeInsets.only(top: 15.0),
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
            child: PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return {'Setting', 'Logout'}.map((String item) {
                  return PopupMenuItem(value: item, child: Text(item));
                }).toList();
              },
              onSelected: selectedItem,
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

  void selectedItem(String value) {
    switch (value) {
      case 'Setting': {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const SettingsPage())
          )
        );
      }
      break;
      case 'About':
    }
  }
}
