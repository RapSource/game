import 'package:flutter/material.dart';
import 'package:gameku/page/category.dart';
import 'package:gameku/page/home.dart';

class BottomTapBar extends StatefulWidget {
  const BottomTapBar({super.key});

  @override
  State<BottomTapBar> createState() => _BottomTapBarState();
}

class _BottomTapBarState extends State<BottomTapBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CategoryPage(),
    // GameList(),
    // GameList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Daftar Game'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori Game'
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite),
          //   label: 'Favorite'
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Profile'
          // )
        ],
      ),
    );
  }
}
