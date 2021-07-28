import 'package:flutter/material.dart';
import 'package:recipe_gram/models/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Expanded(child: Image.asset(recipe!.image), flex: 1),
              Expanded(child: Image.asset('assets/spaghetti.png'), flex: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TEST", style: TextStyle(color: Colors.black)),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
                flex: 2,
              )
            ],
          ),
        ));
  }
}
