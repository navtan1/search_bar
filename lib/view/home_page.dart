import 'package:flutter/material.dart';
import 'package:search_bar/view/intro_screen.dart';
import 'package:search_bar/view/search_items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hii'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchItems());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              prefs
                  .remove('Password')
                  .then((value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IntroScreen(),
                      )));
            },
            child: Text('Log out'),
          ),
        ),
      ),
    );
  }
}
