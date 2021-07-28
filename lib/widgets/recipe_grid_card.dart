import 'package:flutter/material.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/screens/recipe/recipe_details.dart';

class RecipeGridView extends StatelessWidget {
  final Recipe recipe;
  RecipeGridView({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: FadeInImage.assetNetwork(
        height: 150,
        fit: BoxFit.fill,
        image: recipe.image,
        placeholder: 'assets/choose-image.png',
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => new RecipeDetail(
              sRecipe: recipe,
            ),
          ),
        );
      },
    );
  }
}
