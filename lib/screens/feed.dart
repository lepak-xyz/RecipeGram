import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/providers/recipe_provider.dart';
import 'package:recipe_gram/widgets/feed_card.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Recipe>? recipeItem;

  @override
  void initState() {
    super.initState();
    _refreshLocalFeed();
    context.read<RecipeProvider>().fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RecipeProvider>(context);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(18.0),
      child: RefreshIndicator(
        child: (vm.getRecipes().isEmpty)
            ? SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  child: Text("No information available"),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                ),
              )
            : ListView.builder(
                itemCount: vm.getRecipes().length,
                itemBuilder: (context, idx) {
                  return FeedCard(recipe: vm.getRecipes()[idx]);
                },
              ),
        onRefresh: _refreshLocalFeed,
      ),
      // RefreshIndication
    );
  }

  Future<Null> _refreshLocalFeed() async {
    context.read<RecipeProvider>().fetchRecipes();
    /*
    RecipeProvider.fetchRecipe().then((recipe) {
      setState(() {
        recipeItem = recipe;
      });
    });

     */
  }
}
