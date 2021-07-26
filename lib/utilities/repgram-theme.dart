import 'package:flutter/material.dart';

class RepGramColor {
  static final Color primary = Color.fromRGBO(201, 24, 74, 1);
  static final Color secondary = Color.fromRGBO(255, 87, 117, 1);
  static final RepGramColor instance = RepGramColor();

  static final Map<int, Color> primarySwatch = {
    50: Color.fromRGBO(primary.red, primary.green, primary.blue, .1),
    100: Color.fromRGBO(primary.red, primary.green, primary.blue, .2),
    200: Color.fromRGBO(primary.red, primary.green, primary.blue, .3),
    300: Color.fromRGBO(primary.red, primary.green, primary.blue, .4),
    400: Color.fromRGBO(primary.red, primary.green, primary.blue, .5),
    500: Color.fromRGBO(primary.red, primary.green, primary.blue, .6),
    600: Color.fromRGBO(primary.red, primary.green, primary.blue, .7),
    700: Color.fromRGBO(primary.red, primary.green, primary.blue, .8),
    800: Color.fromRGBO(primary.red, primary.green, primary.blue, .9),
    900: Color.fromRGBO(primary.red, primary.green, primary.blue, 1),
  };
}