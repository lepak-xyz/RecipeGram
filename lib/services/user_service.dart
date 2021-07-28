import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/models/user_model.dart';
import 'package:recipe_gram/providers/user_provider.dart';
import 'package:recipe_gram/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String API_ENDPOINT = Utils.apiHost + "/users";

  static Future<bool> checkToken(UserProvider notifier) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString("token");

    if (token != null && token != "") {
      final resp = await http.get(
        Uri.parse(API_ENDPOINT),
        headers: {'Authorization': 'Bearer $token'},
      );

      final respJson = jsonDecode(resp.body);

      if (resp.statusCode == 200) {
        if (respJson['data'] != null) {
          notifier.user = User.fromJson(respJson['data']);
          notifier.auth = true;
          return true;
        }
      }

      _prefs.remove("token");
      notifier.auth = false;
      Fluttertoast.showToast(msg: "Token expired. Please re-login.");
    }

    return false;
  }

  static Future<bool> login(
    String username,
    String password,
    UserProvider notifier,
  ) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    var response = await http.get(
      Uri.parse(
          Utils.apiHost + "/auth/login?email=$username&password=$password"),
    );
    final jsonResponse = json.decode(response.body);

    if (jsonResponse['access_token'] != null) {
      _prefs.setString("token", jsonResponse['access_token']);
      notifier.user = User.fromJson(jsonResponse['user']);
      notifier.auth = true;

      return true;
    } else if (jsonResponse['error'] != null) {
      final errors = jsonResponse['error'];

      if (errors.values != null) {
        Fluttertoast.showToast(
            msg: errors.values.join(", "), toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg: jsonResponse['error'], toastLength: Toast.LENGTH_LONG);
      }
    }

    return false;
  }

  static Future<bool> register(
    String email,
    String username,
    String password,
    String phone,
    UserProvider notifier,
  ) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(Utils.apiHost +
        "/auth/register?email=$email&username=$username&password=$password&phone=$phone"));
    final jsonResponse = json.decode(response.body);

    if (jsonResponse['access_token'] != null) {
      _preferences.setString("token", jsonResponse['access_token']);
      final userJson = jsonResponse['user'];

      notifier.user = User.fromJson(userJson);
      notifier.auth = true;
      return true;
    } else if (jsonResponse['error'] != null) {
      final errors = jsonResponse['error'];
      Fluttertoast.showToast(
          msg: errors.values.join(", "), toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: "Server Error. Contact helpdesk. [${response.statusCode}]");
    }

    return false;
  }

  // TODO
  // Return `int` error code for textform validation in settings
  static Future<bool> updateProfile(
      String name, String username, String bio, UserProvider notifier) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString("token");

    var response = await http.put(
      Uri.parse(API_ENDPOINT + "/update"),
      body: jsonEncode(<String, String>{
        'id': notifier.user!.id,
        'username': username.trim().toString(),
        'full_name': name.trim(),
        'bio': bio.trim(),
      }),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json"
      },
    );
    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      checkToken(notifier);
      return true;
    } else {
      Fluttertoast.showToast(
          msg: "An error has been occurred. [Err: ${jsonResponse['error']}]",
          toastLength: Toast.LENGTH_LONG);
    }

    return false;
  }

  static Future<bool> updatePhoto(XFile file, UserProvider notifier) async {
    //Map<String, String> headers = { "Accesstoken": "access_token"};
    //multipartRequest.headers.addAll(headers);
    var flag = false;
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString("token");

    if (token != null && token != "") {
      var uri = Uri.parse(API_ENDPOINT + "/updateImage");
      var request = new http.MultipartRequest("POST", uri);
      request.headers['Authorization'] = 'Bearer $token';

      var pic = await http.MultipartFile.fromPath("image", file.path);

      request.files.add(pic);
      final response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) {
        final jsonResponse = json.decode(value);

        if (response.statusCode == 201) {
          if (jsonResponse['status'] == 200) {
            checkToken(notifier);
            flag = true;
          } else {
            Fluttertoast.showToast(
                msg:
                    "An error has been occurred. [${jsonResponse['status']}: ${jsonResponse['message']}]");
          }
        } else {
          Fluttertoast.showToast(
              msg: "${response.statusCode}: ${jsonResponse['error']}");
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Token expired. Please re-login.");
    }

    return flag;
  }

  static retrieveUserExtraInfo(UserProvider notifier) async {
    getPosts(notifier);
    getFavourites(notifier);
  }

  static addPosts(XFile file, String caption, String name, String ingredients,
      String instructions, UserProvider notifier) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString("token");

    if (token != null && token != "") {
      final data = {
        'name': name.trim(),
        'caption': caption.trim(),
        'ingredients': ingredients.trim(),
        'instructions': instructions.trim(),
      };

      var uri = Uri.parse(API_ENDPOINT + "/recipe");
      var request = new http.MultipartRequest("POST", uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['data'] = jsonEncode(data);

      var pic = await http.MultipartFile.fromPath("image", file.path);

      request.files.add(pic);
      http.Response response =
          await http.Response.fromStream(await request.send());
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        return true;
      } else if (jsonResponse['error']) {
        Fluttertoast.showToast(
            msg:
                "[Add Recipe] ${response.statusCode}: ${jsonResponse['error']} ");
      } else {
        Fluttertoast.showToast(
            msg:
                "Unknown error occurred. Contact Admin [${response.statusCode}]");
        print("Status: " + response.statusCode.toString());
        print(response.body);
      }
    }

    return false;
  }

  static addToFavourite(Recipe rep, UserProvider notifier) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString("token");

    if (token != null && token != "") {
      final response = await http.get(
        Uri.parse(API_ENDPOINT + "/favourites?action=add&rid=${rep.id}"),
        headers: {'Authorization': 'Bearer ${token}'},
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        notifier.favourite.add(rep);
        return true;
      } else {
        print(jsonResponse);
        Fluttertoast.showToast(
            msg: "[AddFavourite] ${response.statusCode}: $jsonResponse");
      }
    }

    return true;
  }

  static removeFromFavourite(Recipe rep, UserProvider notifier) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString("token");

    if (token != null && token != "") {
      final response = await http.get(
        Uri.parse(API_ENDPOINT + "/favourites?action=remove&rid=${rep.id}"),
        headers: {'Authorization': 'Bearer $token'},
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (notifier.favourite.contains(rep)) {
          notifier.favourite.remove(rep);
        }
        return true;
      } else {
        print(jsonResponse);
        Fluttertoast.showToast(
            msg: "[RemoveFavourite] ${response.statusCode}: $jsonResponse");
      }
    }

    return false;
  }

  static getPosts(UserProvider notifier) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString("token");

    if (token != null && token != "") {
      final response = await http.get(
        Uri.parse(API_ENDPOINT + "/recipe"),
        headers: {'Authorization': 'Bearer ${token}'},
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonResponse['status'] != null && jsonResponse['status'] == 200) {
          final data = jsonResponse['data'] as List;

          notifier.posts =
              data.map<Recipe>((item) => Recipe.fromJson(item)).toList();
        } else {
          Fluttertoast.showToast(
              msg: "Posts: Server error. Please contact admin.");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Posts: ${response.statusCode}: ${jsonResponse['error']}");
        print(jsonResponse['error']);
      }
    } else {
      Fluttertoast.showToast(msg: "Posts: Token expired. Please re-login.");
    }

    return false;
  }

  static getFavourites(UserProvider notifier) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString("token");

    if (token != null && token != "") {
      final response = await http.get(
        Uri.parse(API_ENDPOINT + "/favourites"),
        headers: {'Authorization': 'Bearer ${token}'},
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonResponse['status'] != null && jsonResponse['status'] == 200) {
          final data = jsonResponse['data'] as List;

          notifier.favourite =
              data.map<Recipe>((item) => Recipe.fromJson(item)).toList();
        } else {
          Fluttertoast.showToast(
              msg: "Favourite: Server error. Please contact admin.");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Favourite: ${response.statusCode}: ${jsonResponse['error']}");
      }

      if (jsonResponse['error'] != null) {
        print(jsonResponse['error']);
      }
    } else {
      Fluttertoast.showToast(msg: "Favourite: Token expired. Please re-login.");
    }
  }
}
