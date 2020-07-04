import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iotflutterapp/MapScreen.dart';
import 'package:iotflutterapp/Signup.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
//    theme: ThemeData.dark(),
    home: LoginPage(),
    routes: <String, WidgetBuilder>{
      '/SignUpPage': (context) => SignUpPage(),
      '/LoginPage': (context) => LoginPage(),
      '/MapPage': (context) => MapScreen(),
      '/SignOut': (context) => LoginPage(),
    },
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
//  TextEditingController nameController = TextEditingController();
//  TextEditingController passwordController = TextEditingController();
  String _user;
  String _pass;
  final formKey = GlobalKey<FormState>();
  final String signinAPI = 'http://185.205.209.236:8000/register/user/';

  void _login() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
//      print(_sigin(_user, _pass).toString());
      Navigator.pushReplacementNamed(context, '/MapPage');
    }
  }

  // sign in method
//  Future<Map<String, dynamic>> _sigin(String username, String password) async
  Future<bool> _sigin(String username, String password) async {
    final Map<String, dynamic> authData = {
      "username": username,
      "password": password
    };

    final http.Response response = await http.post(signinAPI,
        body: json.encode(authData),
        headers: {"Content-Type": "application/json"});

//    final Map<String, dynamic> authResponseData = json.decode(response.body);

    if (response.statusCode == 400) {
//      if (authResponseData.containsKey("error")) {
//        if (authResponseData["error"] == "invalid_credentials") {
////          return {'success': false, 'message': 'Invalid User!'};
//          return false;
//        }
//      }
      return false;
    }

    if (response.statusCode == 200) {
      return true;
//      return {'success': true, 'message': 'Successfuly login!'};
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Trolly Management System')),
          ),
          body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'TMS',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Enter your info',
                        style: TextStyle(fontSize: 20),
                      )),
//                  Container(
//                    padding: EdgeInsets.all(10),
//                    child: TextField(
//                      controller: nameController,
//                      decoration: InputDecoration(
//                        border: OutlineInputBorder(),
//                        labelText: 'نام کاربری',
//                      ),
//                    ),
//                  ),
//                  Container(
//                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                    child: TextField(
//                      obscureText: true,
//                      controller: passwordController,
//                      decoration: InputDecoration(
//                        border: OutlineInputBorder(),
//                        labelText: 'رمز عبور',
//                      ),
//                    ),
//                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                            decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                )),
                            validator: (input) => !input.contains('@')
                                ? 'Not a valid Email'
                                : null,
                            onSaved: (input) => _user = input,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                icon: Icon(Icons.security),
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(25.0))),
                            validator: (input) => input.length < 6
                                ? 'Password should at least be 6 characters'
                                : null,
                            onSaved: (input) => _pass = input,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    textColor: Colors.blue,
                    child: Text('Forgot Password'),
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Login'),
                        onPressed: () {
//                        print(nameController.text);
//                        print(passwordController.text);
                          _login();
                        },
                      )),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Text('Don\'t have an account yet? '),
                      FlatButton(
                        textColor: Colors.blue,
                        child: Text(
                          'Sign Up!',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          //signup screen
                          Navigator.pushReplacementNamed(
                              context, '/SignUpPage');
                        },
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ))
                ],
              ))),
    );
  }
}
