import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final String signupAPI = 'http://185.205.209.236:8000/register/user/';
  Response response;
  var dio = Dio();
  String _user;
  String _pass;
  String _email;
  String _phoneNumber;
  final formKey = GlobalKey<FormState>();

//  Future<Map<String, dynamic>> signup(
  Future<String> signup(
      String username, String password, String email, String number) async {
    final Map<String, dynamic> authData = {
      "username": username,
      "email": email,
      "phone_number": number,
      "password": password
    };

    FormData formData = new FormData.fromMap(authData);
//    final http.Response response = await http.post(signupAPI,
//        body: json.encode(authData),
//        headers: {"Content-Type": "application/json"});
//
//    final Map<String, dynamic> authResponseData = json.decode(response.body);

    response = await dio.post(signupAPI, data: formData);

//    if (response.statusCode == 400) {
////      if (authResponseData.containsKey("error")) {
////        if (authResponseData["error"] == "invalid_credentials") {
////          return {'success': false, 'message': 'Invalid User!'};
////        }
////      }
//      return {'success': false, 'message': 'Unsuccessful SignUp!'};
//    }
//
//    if (response.statusCode == 200) {
//      return {'success': true, 'message': 'Successful SignUp!'};
//    }
    return response.data.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          decoration: InputDecoration(
                              icon: Icon(Icons.perm_identity),
                              labelText: 'User',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(),
                              )),
//                          validator: (input) =>
//                              !input.contains('@') ? 'Not a valid Email' : null,
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
                          validator: (input) =>
                              !input.contains('@') ? 'Not a valid Email' : null,
                          onSaved: (input) => _email = input,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(25.0))),
//                          validator: (input) => input.length < 6
//                              ? 'Password should at least be 6 characters'
//                              : null,
                          onSaved: (input) => _phoneNumber = input,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('SignUp'),
                      onPressed: () {
//                        print(nameController.text);
//                        print(passwordController.text);
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          print(_user + _pass + _email + _phoneNumber);
//                        print(_sigin(_user, _pass).toString());
                          print(signup(_user, _pass, _email, _phoneNumber));
//                          Navigator.pushReplacementNamed(context, '/MapPage');
                        }
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //Login screen
                        Navigator.pushReplacementNamed(context, '/LoginPage');
                      },
                    ),
                    Text('Do you have an account?'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
              ],
            )));
  }
}
