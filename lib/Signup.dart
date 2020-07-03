import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final String signupAPI = '';

  Future<Map<String, dynamic>> sigup(
      String username, String password, String email, String number) async {
    final Map<String, dynamic> authData = {
      "username": username,
      "password": password,
      "email": email,
      "number": number
    };

    final http.Response response = await http.post(signupAPI,
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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'رمز عبور',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ایمیل',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: TextField(
                    controller: numberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'شماره تلفن',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('ثبت نام'),
                      onPressed: () {
//                        print(nameController.text);
//                        print(passwordController.text);
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'ورود',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //Login screen
                        Navigator.pushReplacementNamed(context, '/LoginPage');
                      },
                    ),
                    Text('از قبل حساب کاربری دارید؟'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
