import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_gram/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));

    return MaterialApp(
      title: 'RecipeGram',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.red,
          primarySwatch: Colors.red,
          textTheme: const TextTheme(
              bodyText2: TextStyle(color: Colors.white),
              headline3: TextStyle(color: Colors.white))),
      //home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/login': (context) => LoginPage()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              scale: 2.5,
            ),
            Text(
              'RecipeGram',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text('Where your recipe get known'),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                child: Text("LET'S GET STARTED"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.red[800],
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15)))
          ],
        ),
      ),
    );
  }
}
