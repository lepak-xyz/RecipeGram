import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_gram/screens/home.dart';
import 'package:recipe_gram/screens/login.dart';
import 'package:recipe_gram/screens/register.dart';
import 'package:recipe_gram/utilities/repgram-theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences _sharedPreferences;
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    if (_sharedPreferences.getBool("first_time") != null) {
      setState(() {
        showButton = true;
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        if (_sharedPreferences.getString("token") != null) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        }
      });
    }
  }

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
            showButton
                ? ElevatedButton(
                    onPressed: () {
                      //Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    child: Text("LET'S GET STARTED"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.red[800],
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 15)))
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
