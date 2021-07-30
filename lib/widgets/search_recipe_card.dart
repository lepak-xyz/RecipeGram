import 'package:flutter/material.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/screens/recipe/recipe_details.dart';
import 'package:recipe_gram/utilities/repgram-theme.dart';

class SearchRecipeCard extends StatelessWidget {
  final Recipe sRecipe;
  SearchRecipeCard({required this.sRecipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Card(
        color: RepGramColor.secondary,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new RecipeDetail(sRecipe: sRecipe,)));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                  child: Image.network(
                    sRecipe.image,
                    height: 120,
                    fit: BoxFit.fill,
                    errorBuilder:
                        (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return const Text('Image not found.', textAlign: TextAlign.center,);
                    },
                  ),
                ),
                flex: 40,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            sRecipe.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${sRecipe.heat} heat",
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: 5.0,),
                            Image.asset('assets/heat_small.png', width: 17, height: 20,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                flex: 66,
              )
            ],
          ),
        ),
      ),
    );
  }
}
