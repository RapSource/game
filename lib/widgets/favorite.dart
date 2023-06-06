import 'package:flutter/material.dart';

import '../ui/favorite_list_page.dart';

class LoveIcon extends StatefulWidget {
  const LoveIcon({super.key});

  @override
  State<LoveIcon> createState() => _LoveIconState();
}

class _LoveIconState extends State<LoveIcon> {
  bool isLove = false;
  final List _favorite = const [];

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isLove = !isLove;
            if (isLove = true) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // title: const Text('Adding to Favorite'),
                    content: const Text('Adding to Favorite'),
                  );
                }
              );
            }
          });
        },
        icon: Icon(
          size: 32.0,
          isLove ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ));
  }
}
