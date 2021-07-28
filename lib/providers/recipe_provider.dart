import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/utilities/utils.dart';

class RecipeProvider {
  static Future<List<Recipe>> fetchRecipe() async {
    final response = await http.get(
        Uri.parse(Utils.apiHost + "/recipe")
    );

    final responseJson = jsonDecode(response.body)['data'] as List;
    return responseJson.map<Recipe>((item) => Recipe.fromJson(item)).toList();
  }
}


