import 'dart:async';

import 'package:flutter/material.dart';
import 'package:search_bar/view/home_page.dart';
import 'package:search_bar/view/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userData;

  @override
  void initState() {
    getUserData().whenComplete(
      () => Timer(
        Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  userData == null ? IntroScreen() : HomePage(),
            ),
          );
        },
      ),
    );
    super.initState();
  }

  Future getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString('Password');

    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
