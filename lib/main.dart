import 'dart:convert';

import 'package:flutter/material.dart';
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
    },
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final String signinAPI = '';
  Future<Map<String, dynamic>> sigin(String username, String password) async {
    final Map<String, dynamic> authData = {
      "username": username,
      "password": password
    };

    final http.Response response = await http.post(signinAPI,
        body: json.encode(authData),
        headers: {"Content-Type": "application/json"});

    final Map<String, dynamic> authResponseData = json.decode(response.body);

    if (response.statusCode == 400) {
      if (authResponseData.containsKey("error")) {
        if (authResponseData["error"] == "invalid_credentials") {
          return {'success': false, 'message': 'Invalid User!'};
        }
      }
    }

    if (response.statusCode == 200) {
      return {'success': true, 'message': 'Successfuly login!'};
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('سامانه مدیریت چرخ دستی')),
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
                      'اطلاعات خود را وارد کنید',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'نام کاربری',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'رمز عبور',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('رمز عبور را فراموش کرده ام'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('ورود'),
                      onPressed: () {
//                        print(nameController.text);
//                        print(passwordController.text);
                        Navigator.pushReplacementNamed(context, '/MapPage');
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'ثبت نام',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.pushReplacementNamed(context, '/SignUpPage');
                      },
                    ),
                    Text('حساب کاربری ندارید؟'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
