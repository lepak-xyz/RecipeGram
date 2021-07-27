import 'package:flutter/material.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/widgets/search_recipe_card.dart';

class SearchPage extends StatefulWidget {
  List<Recipe> recipeList;

  SearchPage({required this.recipeList});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: widget.recipeList.length > 0 ? ListView.builder(
          itemCount: widget.recipeList.length,
          itemBuilder: (context, idx) {
            return SearchRecipeCard(sRecipe: widget.recipeList[idx],);
          },
        ) : SizedBox(),
      ),
    );
  }
}
