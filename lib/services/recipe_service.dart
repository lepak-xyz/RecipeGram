import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/utilities/utils.dart';

class RecipeService {
  static Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse(Utils.RECIPE_ENDPOINT));

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body)['data'] as List;
      return responseJson.map<Recipe>((item) => Recipe.fromJson(item)).toList();
    } else {
      Fluttertoast.showToast(msg: "Recipe: Unable to fetch recipe!");
    }

    return [];
  }
}