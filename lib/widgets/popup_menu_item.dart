import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/scheduling_provider.dart';
import '../ui/about_page.dart';
import '../ui/settings_page.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(value: 1, child: Text('Setting')),
        const PopupMenuItem(value: 2, child: Text('About')),
      ],
      onSelected: (value) {
        if (value == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChangeNotifierProvider<SchedulingProvider>(
                create: (_) => SchedulingProvider(),
                child: const SettingsPage());
          }));
        } else if (value == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const AboutPage())));
        }
      },
    );
  }
}
