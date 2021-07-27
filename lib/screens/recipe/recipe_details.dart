import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/models/user_model.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe sRecipe;
  const RecipeDetail({required this.sRecipe});

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  late User _user;
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _user = User.fromJson(json.decode(_prefs.getString("user") ?? ""));

    setState(() {
      isFavourite = _user.favourites.contains(widget.sRecipe.id);
    });
  }

  addToFavourites() async {
    // TODO
    // ADD TO DATABASE
    setState(() {
      isFavourite = true;
    });
    return false;
  }

  removeFavourites() async {
    // TODO
    // REMOVE FROM DATABASE
    isFavourite = false;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final ctxSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Recipe Details"),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.favorite),
                            title: isFavourite ? Text("Remove from Favourite") : Text("Add To Favourite"),
                            onTap: () {
                              setState(() {
                                isFavourite = !isFavourite;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.share),
                            title: Text("Share"),
                            onTap: () {
                              Share.share(
                                  "Check out `${widget.sRecipe.name}}` recipe by @${widget.sRecipe.author['username']}");
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.sRecipe.image),
                        fit: BoxFit.cover),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: new Container(
                      height: ctxSize.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.0),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(widget.sRecipe.name),
                ),
                Align(
                  alignment: Alignment(0.9, -7.0),
                  heightFactor: 0.5,
                  child: FloatingActionButton(
                    onPressed: () {
                      print("hehe");
                    },
                    child: Icon(Icons.fireplace),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: Card(
                color: Colors.pink[600],
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        widget.sRecipe.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'Staatliches',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      indent: 25.0,
                      endIndent: 25.0,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Ingredients (${widget.sRecipe.ingredients.length})",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.sRecipe.ingredients.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new Text(
                                  "- ${widget.sRecipe.ingredients.values.elementAt(index)}");
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Instructions (${widget.sRecipe.instructions.length})",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.sRecipe.instructions.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return new Text(
                                  "${index + 1}.${widget.sRecipe.instructions.values.elementAt(index)}");
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            /*
            Container(
              child: Card(
                child: Text("hehe"),
              ),
            ),

             */
          ],
        ),
      ),
    );
  }
}