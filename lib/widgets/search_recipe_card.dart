import 'package:flutter/material.dart';
import 'package:recipe_gram/screens/recipe/recipe_details.dart';
import 'package:recipe_gram/utilities/repgram-theme.dart';

class SearchRecipeCard extends StatelessWidget {
  const SearchRecipeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Card(
        color: RepGramColor.secondary,
        child: InkWell(
          onTap: () {
            //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new RecipeDetail(sRecipe: ,)));
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
                  child: Image.asset(
                    'assets/nasi kerabu.png',
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                ),
                flex: 40,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Nasi Kerabu",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      /*
                      Expanded(
                        child: Card(
                          color: Colors.white54,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "ABC",
                            ),
                          )
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "ABC",
                          textAlign: TextAlign.right,
                        ),
                      ),
                       */
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
