import 'package:flutter/material.dart';
import 'package:gameku/ui/favorite_list_page.dart';
import '../ui/home.dart';


class BottomTapBar extends StatefulWidget {
  static const routeName = '/tabbar';

  const BottomTapBar({super.key});

  @override
  State<BottomTapBar> createState() => _BottomTapBarState();
}

class _BottomTapBarState extends State<BottomTapBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FavoriteList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
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
            label: 'Game'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite'
          ),
        ],
      ),
    );
  }
}
