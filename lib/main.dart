import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recipe_gram/providers/recipe_provider.dart';
import 'package:recipe_gram/providers/user_provider.dart';
import 'package:recipe_gram/screens/home.dart';
import 'package:recipe_gram/screens/login.dart';
import 'package:recipe_gram/screens/register.dart';
import 'package:recipe_gram/utilities/repgram-theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
      ],
      child: MyApp(),
    ),
  );
  //runApp(MyApp());
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
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final token = _sharedPreferences.getString("token");

    if (token != null && token.isNotEmpty) {
      Future.delayed(const Duration(seconds: 1), () {
        context.read<UserProvider>().isLoggedIn().then((flag) {
          if (flag) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          }
        });
      });
    } else {
      setState(() {
        showButton = true;
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
                      Navigator.pushReplacementNamed(
                          context, '/login');
                    },
                    child: Text("LET'S GET STARTED"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.red[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
