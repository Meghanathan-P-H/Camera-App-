import 'package:camera_app/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
void initState() {
  super.initState();
  loginPath(context);
}
  @override
  Widget build(BuildContext context) {
    // loginPath(context);
    return Scaffold(
      backgroundColor: const Color(0xFF68c7c1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/Image/logoforcamera.png',
              height: 100,
              width: 100,
            ),
            Text(
              'CAMERA APP',
              style: GoogleFonts.kanit(textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.amber[100])),
            )
          ],
        ),
      ),
    );
  }

  Future<void> loginPath(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MyHome(),
      ),
    );
  }
}
