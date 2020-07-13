import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class SignUpPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final String signupAPI = 'http://185.205.209.236:8000/register/user/';

//  final String signupAPI = 'https://gorest.co.in/public-api/users?_format=json&access-token=-RcTiY9Qx-uMai_Dyxy72sIqBn4PhrOCxhuZ';
  Response response;
  var dio = Dio();
  String _user;
  String _pass;
  String _email;
  String _role = 'Customer';
  String _phoneNumber;
  final formKey = GlobalKey<FormState>();

//  Future<Map<String, dynamic>> signup(
  Future<Map<String, dynamic>> signup(String username, String password,
      String email, String number, String role) async {
    int roleNum;
    if (role == 'Customer')
      roleNum = 1;
    else
      roleNum = 2;
    final Map<String, dynamic> authData = {
      "username": username,
      "email": email,
      "user_type": roleNum,
      "phone_number": number,
      "password": password
    };

    FormData formData = new FormData.fromMap(authData);

    response = await dio.post(signupAPI, data: formData);
    print(response);
    print(response.data.runtimeType);

    return response.data;
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
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('SignUp'),
                      onPressed: () async {
//                        print(nameController.text);
//                        print(passwordController.text);
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          print(_user +
                              ' ' +
                              _pass +
                              ' ' +
                              _email +
                              ' ' +
                              _phoneNumber);
//                        print(_sigin(_user, _pass).toString());
                          var temp = (await signup(
                              _user, _pass, _email, _phoneNumber, _role));
                          if (temp['status'] == 'ok' && _role == 'Customer')
                            Navigator.pushReplacementNamed(
                                context, '/MapPageCustomer');
                          else if (temp['status'] == 'ok' && _role == 'Worker')
                            Navigator.pushReplacementNamed(
                                context, '/MapPageWorker');
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
