import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_gram/utilities/repgram-theme.dart';

class NewRecipePage extends StatefulWidget {
  @override
  _NewRecipePageState createState() => _NewRecipePageState();
}

class _NewRecipePageState extends State<NewRecipePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Image.asset(
                          'assets/nasi kerabu.png',
                          fit: BoxFit.fill,
                          height: double.infinity,
                        ),
                      ),
                      flex: 33,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a caption...',
                            isDense: true,
                          ),
                        ),
                      ),
                      flex: 66,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Tag',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: RepGramColor.primary,
                          fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // TODO
                    // Add ListView
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          OutlineButton(
                            onPressed: () {},
                            child: Text("Western"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Recipe Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: RepGramColor.primary,
                          fontSize: 18.0),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'What is your secret recipe name?'),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ingredients',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: RepGramColor.primary,
                          fontSize: 18.0),
                    ),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Tell us your secret ingredients...'),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Instructions',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: RepGramColor.primary,
                          fontSize: 18.0),
                    ),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Tell us your magical touch...'),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
