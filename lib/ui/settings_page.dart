import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title:
                Text('Dark Theme', style: GoogleFonts.roboto(fontSize: 18.0)),
            trailing: Switch.adaptive(
              value: false,
              onChanged: (value) {
                defaultTargetPlatform == TargetPlatform.iOS
                    ? showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Coming Soon!'),
                            content:
                                const Text('This feature will be coming soon!'),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        })
                    : showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Coming Soon!'),
                            content:
                                const Text('This feature will be coming soon!'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Ok'))
                            ],
                          );
                        });
              },
            ),
          ),
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(14.0),
          child: GestureDetector(
            onTap: () => exit(0),
            child: Text(
              textAlign: TextAlign.left,
              'Exit',
              style: GoogleFonts.roboto(fontSize: 18.0)
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/mobile-game.png',
              fit: BoxFit.contain,
              height: 35,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Text('Settings',
                  style: GoogleFonts.poppins(
                      color: Colors.yellow,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          children: [
            Image.asset(
              'assets/images/mobile-game.png',
              fit: BoxFit.contain,
              height: 35,
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: Text('Settings',
                  style: GoogleFonts.poppins(
                      color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      child: _buildList(context),
    );
  }
}
