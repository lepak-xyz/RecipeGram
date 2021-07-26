import 'package:flutter/material.dart';
import 'package:recipe_gram/widgets/search_recipe_card.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            SearchRecipeCard(),
            SearchRecipeCard(),
          ],
        ),
      ),
    );
  }
}
