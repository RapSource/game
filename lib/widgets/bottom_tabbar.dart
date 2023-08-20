import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gameku/ui/favorite_list_page.dart';
import '../ui/home.dart';
import '../ui/search_page.dart';

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
    const SearchPage(),
    const FavoriteList(),
  ];

  @override
  Widget build(BuildContext context) {

    CurvedNavigationBar navigationBar = CurvedNavigationBar(
      height: 55,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      animationCurve: Curves.easeIn,
      color: Colors.transparent,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      items: const [
        Icon(Icons.home, size: 27, color: Colors.blueGrey),
        Icon(Icons.search, size: 27, color: Colors.blueGrey),
        Icon(Icons.favorite, size: 27, color: Colors.blueGrey),
      ],
    );

    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
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
            child: navigationBar));
  }
}
