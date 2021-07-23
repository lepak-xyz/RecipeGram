import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

    TextEditingController usernameController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    bool obscureText = true;

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
                    child: Text("Log In", style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 36),),
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
                          topRight: const Radius.circular(50.0)
                      )
                  ),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            SizedBox(),
                            Text("Welcome to RecipeGram",
                                style: TextStyle(color: Colors.red[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24)),
                            ElevatedButton(
                              onPressed: () {}, child: Text("SIGN IN "), style: ElevatedButton.styleFrom(minimumSize: Size(0.8 * width, 40)))
                          ],
                        ) // 0146284528
                      ],
                    ),
                  )
              ),
            )
          ],
        )
    );
  }
}
