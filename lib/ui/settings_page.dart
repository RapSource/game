import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameku/provider/scheduling_provider.dart';
import 'package:gameku/widgets/custom.dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
              onChanged: (value) => customDialog(context),
            ),
          ),
        ),
        const Divider(),
        Material(
          child: ListTile(
            title:
                Text('Scheduling Games', style: GoogleFonts.roboto(fontSize: 18.0)),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.scheduledGames(value);
                    }
                  },
                );
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
