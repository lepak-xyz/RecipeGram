import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/services/recipe_service.dart';
import 'package:recipe_gram/utilities/utils.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipe = [];

  Future<void> fetchRecipes() async {
    this._recipe = await RecipeService.fetchRecipes();
    notifyListeners();
  }

  List<Recipe> getRecipes() {
    return this._recipe;
  }

  static Future<List<Recipe>> fetchRecipe() async {
    final response = await http.get(
        Uri.parse(Utils.apiHost + "/recipe")
    );

    final responseJson = jsonDecode(response.body)['data'] as List;
    return responseJson.map<Recipe>((item) => Recipe.fromJson(item)).toList();
  }
}


