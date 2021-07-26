import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/screens/recipe/recipe_details.dart';
import 'package:recipe_gram/utilities/repgram-theme.dart';

class FeedCard extends StatelessWidget {
  final Recipe recipe;

  const FeedCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    Size ctxSize = MediaQuery.of(context).size;

    return Card(
      color: RepGramColor.secondary,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new RecipeDetail(
                        sRecipe: recipe,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5.0),
                    topLeft: Radius.circular(5.0),
                  ),
                  // TODO
                  // CHANGE BACK TO Image.Network
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(recipe.image),
                          //image: ExactAssetImage('assets/bolognese.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: new Container(
                        height: ctxSize.height * 0.26,
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.4)),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: ctxSize.width * 0.6,
                  child: Text(
                    recipe.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            /*
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0),
                topLeft: Radius.circular(5.0),
              ),
              // TODO
              // CHANGE BACK TO Image.Network
              child: Container(
                child: BackdropFilter(
                  child: Image.asset('assets/bolognese.jpg',
                      height: ctxSize.height * 0.26, fit: BoxFit.fill),
                ),
              ),
            ),

             */
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      "@${recipe.author['username']}",
                      style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    flex: 80,
                  ),
                  Text("${recipe.heat} heat",
                      style: TextStyle(fontSize: 13, color: Colors.white))
                ],
              ),
              subtitle: Text(
                recipe.caption,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
