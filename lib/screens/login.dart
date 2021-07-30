import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:recipe_gram/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isBusy = false;
  bool hidePassword = true;

  String? validate(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  topRight: const Radius.circular(50.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Welcome to RecipeGram",
                      style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: usernameController,
                                validator: validate,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black12,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 2),
                                  ),
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
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: hidePassword,
                                validator: validate,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.black12,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black, width: 2),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    child: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (usernameController.text.isEmpty || passwordController.text.isEmpty || isBusy)
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isBusy = true;
                              });

                              context
                                  .read<UserProvider>()
                                  .login(usernameController.text, passwordController.text)
                                  .then((flag) {
                                if (flag) {
                                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                                  Fluttertoast.showToast(msg: "You have been successfully logged in.");
                                } else {
                                  setState(() {
                                    isBusy = false;
                                  });
                                }
                              });
                            }
                          },
                    child: Text(isBusy ? "Loading..." : "SIGN IN"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(0.8 * width, 40),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text("Register"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
