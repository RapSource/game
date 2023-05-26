import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gameku/page/home.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:gameku/bottom_tabbar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.black87, Colors.blueAccent])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              // color: Colors.amberAccent,
              height: 200,
              width: 250,
              child: LottieBuilder.asset(
                'assets/animations/75126-gaming-console.json',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Game',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 20,
                    )),
                SizedBox(width: 3),
                AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText('KU',
                        textStyle: const TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold))
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  pause: Duration(milliseconds: 5),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
