import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_bar/api_routes/api_routes.dart';
import 'package:search_bar/api_services/sign_up_services.dart';
import 'package:search_bar/model/req/sign_up_req.dart';
import 'package:search_bar/view/home_page.dart';
import 'package:search_bar/view/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fname = TextEditingController();

  final _lname = TextEditingController();

  final _email = TextEditingController();

  final _mobile = TextEditingController();

  final _dob = TextEditingController();

  final _passWord = TextEditingController();

  final _confirmPassword = TextEditingController();

  final _form = GlobalKey<FormState>();

  File? _image;

  var picker = ImagePicker();

  Future getImage() async {
    var imagePicker = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (imagePicker != null) {
        _image = File(imagePicker.path);
      }
    });
  }

  Future uplodImage({String? filename}) async {
    dio.FormData formData = dio.FormData.fromMap({
      'avater':
          await dio.MultipartFile.fromFile(_image!.path, filename: filename)
    });

    dio.Response response =
        await dio.Dio().post(ApiRoutes.logIn, data: formData);

    if (response.data['url'] != null) {
      return response.data['url'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _form,
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
                    Container(
                      height: 100,
                      width: 120,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 4) {
                          return 'atlest 4 character';
                        }
                      },
                      controller: _fname,
                      decoration: InputDecoration(hintText: 'First Name'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 4) {
                          return 'atlest 4 character';
                        }
                      },
                      controller: _lname,
                      decoration: InputDecoration(hintText: 'Last Name'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 10) {
                          return '@email.com';
                        }
                      },
                      controller: _email,
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 10) {
                          return 'atlest 10 number';
                        }
                      },
                      maxLength: 10,
                      controller: _mobile,
                      decoration: InputDecoration(
                        hintText: 'Mobile No',
                        counter: Offstage(),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'enter date of birth';
                        }
                      },
                      controller: _dob,
                      decoration: InputDecoration(hintText: 'Dob'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 8) {
                          return 'atlest 8 character';
                        }
                      },
                      controller: _passWord,
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 8) {
                          return 'atlest 8 character';
                        }
                      },
                      controller: _confirmPassword,
                      decoration: InputDecoration(hintText: 'Confirm Password'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String url = await uplodImage(
                            filename:
                                "${DateTime.now()}${Random().nextInt(1000)}${_image!.path}");

                        if (_form.currentState!.validate()) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          SignUpModel _model = SignUpModel();
                          _model.fname = _fname.text;
                          _model.lname = _lname.text;
                          _model.email = _email.text;
                          _model.mobile = _mobile.text;
                          _model.dob = _dob.text;
                          _model.password = _passWord.text;
                          _model.confirmPassword = _confirmPassword.text;
                          _model.clientKey = '1595922666X5f1fd8bb5f662';
                          _model.deviceType = 'MOB';

                          bool status = await SignUpServices.getSignUp(
                              reqBody: _model.toJson());

                          if (status == true) {
                            prefs.setString('Password', _passWord.text);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  SnackBar(
                                    content: Text('Successfuly !'),
                                    duration: Duration(seconds: 2),
                                  ),
                                )
                                .closed
                                .then(
                                  (value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('failed')));
                          }
                        }
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
