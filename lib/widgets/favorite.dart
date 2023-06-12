import 'package:flutter/material.dart';

class LoveIcon extends StatefulWidget {
  const LoveIcon({super.key});

  @override
  State<LoveIcon> createState() => _LoveIconState();
}

class _LoveIconState extends State<LoveIcon> {
  bool isLove = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isLove = !isLove;
          });
        },
        icon: Icon(
          size: 32.0,
          isLove ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ));
  }
}
