import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iotflutterapp/MapScreen_Customer.dart';
import 'package:iotflutterapp/MapScreen_Worker.dart';
import 'package:iotflutterapp/Signup.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
//    theme: ThemeData.dark(),
    home: LoginPage(),
    routes: <String, WidgetBuilder>{
      '/SignUpPage': (context) => SignUpPage(),
      '/LoginPage': (context) => LoginPage(),
      '/MapPageCustomer': (context) => MapScreenCustomer(),
      '/MapPageWorker': (context) => MapScreenWorker(),
      '/SignOut': (context) => LoginPage(),
    },
  ));
}

String _user;

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
//  TextEditingController nameController = TextEditingController();
//  TextEditingController passwordController = TextEditingController();

  String _pass;
  String _role = 'Customer';
  Response response;
  var dio = Dio();
  final formKey = GlobalKey<FormState>();
  final String signinAPI = 'http://185.205.209.236:8000/login/';

  void _login() async {}

  // sign in method
//  Future<Map<String, dynamic>> _sigin(String username, String password) async
  Future<Map<String, dynamic>> _sigin(
      String username, String password, String role) async {
    int roleNum;
    if (role == 'Customer')
      roleNum = 1;
    else
      roleNum = 2;
    final Map<String, dynamic> authData = {
      "username": username,
      "password": password,
      "user_type": roleNum
    };

//    final http.Response response = await http.post(signinAPI,
//        body: json.encode(authData),
//        headers: {"Content-Type": "application/json"});

//    final Map<String, dynamic> authResponseData = json.decode(response.body);
    FormData formData = new FormData.fromMap(authData);
    response = await dio.post(signinAPI, data: formData);
    print(response);
//    if (response.statusCode == 400) {
////      if (authResponseData.containsKey("error")) {
////        if (authResponseData["error"] == "invalid_credentials") {
//////          return {'success': false, 'message': 'Invalid User!'};
////          return false;
////        }
////      }
//      print(response.data);
//      return response.data;
//    }
//
//    if (response.statusCode == 200) {
//      print(response.data);
//      return response.data;
////      return {'success': true, 'message': 'Successfuly login!'};
//    }
    return response.data;
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
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                            decoration: InputDecoration(
                                icon: Icon(Icons.perm_identity),
                                labelText: 'Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                )),
//                            validator: (input) => !input.contains('@')
//                                ? 'Not a valid Email'
//                                : null,
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
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButton<String>(
                            value: _role,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.blueGrey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _role = newValue;
                              });
                              print(_role);
                            },
                            items: <String>['Customer', 'Worker']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                        onPressed: () async {
//                        print(nameController.text);
//                        print(passwordController.text);
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            var temp = (await _sigin(_user, _pass, _role));
                            if (temp['status'] == 'ok' && _role == 'Customer')
                              Navigator.pushReplacementNamed(
                                  context, '/MapPageCustomer');
                            else if (temp['status'] == 'ok' &&
                                _role == 'Worker')
                              Navigator.pushReplacementNamed(
                                  context, '/MapPageWorker');
                          }
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
