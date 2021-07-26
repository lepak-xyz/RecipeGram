import 'dart:convert';

import 'package:recipe_gram/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  static Future<String?> login(String username, String password) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(Utils.apiHost + "login?email=$username&password=$password"));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if(jsonResponse['access_token']) {
        _prefs.setString("token", jsonResponse['access_token']).then((value) => () {
          return jsonResponse['access_token'];
        });
      } else if(jsonResponse['error']) {
        return jsonResponse['error'];
      }

    }

    return null;
  }

  static Future<void> updateProfile() async {
  }
}