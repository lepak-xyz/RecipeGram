import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_gram/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  Future<bool> register(
    String email,
    String username,
    String password,
    String phone,
  ) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(Utils.apiHost + "/auth/register?email=$email&username=$username&password=$password&phone=$phone"));
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
    final ctxSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        Container(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: ctxSize.height * 0.30,
              width: ctxSize.width * 0.60,
              child: Center(
                child: Text(
                  "Register",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ctxSize.height * 0.75,
              width: ctxSize.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(50.0),
                  topRight: const Radius.circular(50.0),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.black12,
                            filled: true,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Username
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
                          height: 8,
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
                      height: 10.0,
                    ),
                    // Password
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
                          height: 8,
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
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Phone No
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.black12,
                            filled: true,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Button
                    ElevatedButton(
                        onPressed: (emailController.text.isEmpty ||
                                usernameController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                phoneController.text.isEmpty)
                            ? null
                            : () {
                                register(
                                        emailController.text,
                                        usernameController.text,
                                        passwordController.text,
                                        phoneController.text)
                                    .then((flag) {
                                  if (flag) {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/home', (route) => false);
                                  }
                                });
                              },
                        child: Text("Register")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Login"))
                      ],
                    )
                  ],
                ),
              ),
            )),
      ],
    ));
  }
}
