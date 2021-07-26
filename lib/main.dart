import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_gram/screens/account/profile.dart';
import 'package:recipe_gram/screens/account/settings.dart';
import 'package:recipe_gram/screens/home.dart';
import 'package:recipe_gram/screens/login.dart';
import 'package:recipe_gram/screens/register.dart';
import 'package:recipe_gram/screens/search.dart';
import 'package:recipe_gram/utilities/repgram-theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: RepGramColor.primary));

    return MaterialApp(
      title: 'RecipeGram',
      theme: ThemeData(
          scaffoldBackgroundColor: RepGramColor.primary,
          primarySwatch: MaterialColor(0xFFC9184A, RepGramColor.primarySwatch),
          textTheme: const TextTheme(
              bodyText2: TextStyle(color: Colors.white),
              bodyText1: TextStyle(color: Colors.white),
              headline3: TextStyle(color: Colors.white))),
      //home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
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
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  //Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
