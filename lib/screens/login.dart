import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_gram/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Future<bool> login(String email, pass) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(Utils.apiHost + "/auth/login?email=$email&password=$pass"));
    final jsonResponse = json.decode(response.body);

    if (jsonResponse['access_token'] != null) {
      _preferences.setString("token", jsonResponse['access_token']);
      _preferences.setString("user", json.encode(jsonResponse['user']));

      return true;
    } else if(jsonResponse['error'] != null) {
      final errors = jsonResponse['error'];
      Fluttertoast.showToast(msg: errors.values.join(", "), toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(msg: "Server Error. Contact helpdesk. [${response.statusCode}]");
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height * 0.30,
                width: width * 0.60,
                child: Center(
                  child: Text(
                    "Log In",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.70,
              width: width,
              decoration: new BoxDecoration(
                  color: Color(0xFFF3F3F5),
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(50.0),
                      topRight: const Radius.circular(50.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Welcome to RecipeGram",
                      style: TextStyle(
                          color: Colors.red[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.black12,
                                filled: true,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.black12,
                                filled: true,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (usernameController.text.isEmpty || passwordController.text.isEmpty) ? null : () {
                      login(usernameController.text, passwordController.text).then((flag) {
                        if (flag) {
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                          Fluttertoast.showToast(msg: "You have been successfully logged in.");
                        }
                      });
                    },
                    child: Text("SIGN IN"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(0.8 * width, 40),
                    ),
                  ),
                  SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text("Register"))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
