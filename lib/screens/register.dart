import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:recipe_gram/providers/user_provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  String? validate(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
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
                child: Form(
                  key: _formKey,
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
                            validator: validate,
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
                            validator: validate,
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
                            validator: validate,
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
                            validator: validate,
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Fluttertoast.showToast(msg: "Loading...");

                              context
                                  .read<UserProvider>()
                                  .register(
                                    emailController.text,
                                    usernameController.text,
                                    passwordController.text,
                                    phoneController.text,
                                  )
                                  .then((value) {
                                if (value) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/home', (route) => false);
                                }
                              });
                            }
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
              ),
            )),
      ],
    ));
  }
}
