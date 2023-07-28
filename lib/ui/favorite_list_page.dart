import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameku/ui/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/data/db/database_helper.dart';
import '../provider/database_provider.dart';
import '../provider/result_state.dart';
import '../provider/scheduling_provider.dart';
import '../widgets/platform_widget.dart';
import 'about_page.dart';
import 'detail_page.dart';

class FavoriteList extends StatelessWidget {
  static const routeName = '/favorite_page';

  static const String favoriteTitle = 'Favorite';

  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child:
          PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/mobile-game.png',
              fit: BoxFit.contain,
              height: 35,
            ),
            Container(
                margin: const EdgeInsets.only(top: 15.0, left: 5.0),
                child: Text(favoriteTitle,
                    style: GoogleFonts.poppins(
                        color: Colors.yellow, fontWeight: FontWeight.bold)))
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<int>(
                elevation: 2,
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(value: 1, child: Text('Setting')),
                  const PopupMenuItem(value: 2, child: Text('About')),
                ],
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChangeNotifierProvider<SchedulingProvider>(
                          create: (_) => SchedulingProvider(),
                          child: const SettingsPage());
                    }));
                  } else if (value == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const AboutPage())));
                  }
                },
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
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(favoriteTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: provider.favorite.length,
          itemBuilder: (context, index) {
            var favoriteGame = provider.favorite[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, DetailPage.routeName,
                      arguments: favoriteGame.id);
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 230, 228, 228),
                  ),
                  child: Stack(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          favoriteGame.backgroundImage,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                                favoriteGame.name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black54,
                                    fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return Center(
          child: Material(
            child: Text(provider.message),
          ),
        );
      }
    });
  }
}
