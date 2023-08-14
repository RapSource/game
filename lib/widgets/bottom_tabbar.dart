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
    BottomNavigationBar navigationBar = BottomNavigationBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Game'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
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
