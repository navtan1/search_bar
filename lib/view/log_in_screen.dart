import 'package:flutter/material.dart';
import 'package:search_bar/view/intro_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final _email = TextEditingController();
  final _passWord = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IntroScreen(),
                                ));
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                    ],
                  ),
                  SizedBox(
                    height: 180,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 10) {
                        return 'enter the value';
                      }
                    },
                    controller: _email,
                    decoration: InputDecoration(hintText: 'Mobile No'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'minimum 8 character';
                      }
                    },
                    controller: _passWord,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Log In'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
