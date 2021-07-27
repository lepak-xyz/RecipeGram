import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/models/user_model.dart';
import 'package:recipe_gram/screens/account/settings.dart';
import 'package:recipe_gram/screens/recipe/recipe_details.dart';
import 'package:recipe_gram/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late SharedPreferences _prefs;
  List<Recipe> recipeList = <Recipe>[];
  List<Recipe> favRecipeList = <Recipe>[];
  User? _user;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);

    loadUserData();
  }

  Future<bool> loadUserData() async {
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      _user = User.fromJson(json.decode(_prefs.getString("user") ?? ""));
      loadRecipe();
      loadFavRecipe();
    });

    return true;
  }

  Future<void> loadRecipe() async {
    final response = await http.get(
      Uri.parse(Utils.apiHost + "/users/recipe?id=${_user!.id}"),
      headers: {
        'Authorization': 'Bearer ${_prefs.getString("token").toString()}'
      },
    );
    final jsonResponse = json.decode(response.body);

    if (jsonResponse['status'] != null && jsonResponse['status'] == 200) {
      final data = jsonResponse['data'] as List;

      setState(() {
        recipeList = data.map<Recipe>((item) => Recipe.fromJson(item)).toList();
      });
    } else {
      Fluttertoast.showToast(msg: "Server error. Please contact admin.");
    }
  }

  Future<void> loadFavRecipe() async {
    final response = await http.get(
      Uri.parse(Utils.apiHost + "/users/favourites?uid=${_user!.id}&action=get"),
      headers: {
        'Authorization': 'Bearer ${_prefs.getString("token").toString()}'
      },
    );
    final jsonResponse = json.decode(response.body);

    if (jsonResponse['status'] != null && jsonResponse['status'] == 200) {
      final data = jsonResponse['data'] as List;

      setState(() {
        favRecipeList =
            data.map<Recipe>((item) => Recipe.fromJson(item)).toList();
      });
    } else {
      Fluttertoast.showToast(msg: "Server error. Please contact admin.");
    }
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Widget buildPost() {
    return recipeList.length > 0
        ? GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 3,
            children: recipeList.map(
              (recipe) {
                return InkWell(
                  child: Image.network(
                    recipe.image,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new RecipeDetail(
                                  sRecipe: recipe,
                                )));
                  },
                );
              },
            ).toList(),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera,
                  size: 48.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  'No Posts Yet',
                  style: TextStyle(color: Colors.black, fontSize: 24.0),
                ),
              ],
            ),
          );
  }

  Widget buildFavourite() {
    return favRecipeList.length > 0
        ? GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 3,
            children: favRecipeList.map(
              (recipe) {
                return InkWell(
                  child: Image.network(
                    recipe.image,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => new RecipeDetail(
                                  sRecipe: recipe,
                                )));
                  },
                );
              },
            ).toList(),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  size: 48.0,
                ),
                SizedBox(height: 15.0),
                Text(
                  'No Favourites Yet',
                  style: TextStyle(color: Colors.black, fontSize: 24.0),
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 100,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                child: Image.asset('assets/profile.png',
                                    fit: BoxFit.fill, height: 70, width: 70),
                              ),
                            ),
                          ),
                          Container(
                            width: screen.width - 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "3",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${_user != null ? _user!.favourites.length : 0}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Favourite",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _user != null ? _user!.username : "Unknown",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _user != null
                                ? _user!.bio
                                : "This profile has no bio yet.",
                            style: TextStyle(color: Colors.black),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new SettingPage()));
                        },
                        child: Text("Settings"),
                      ),
                    )
                  ],
                ),
              )
            ];
          },
          body: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.dashboard,
                      color: _tabController.index == 0
                          ? Colors.black
                          : Colors.black26,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.favorite,
                      color: _tabController.index == 1
                          ? Colors.black
                          : Colors.black26,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildPost(),
                    buildFavourite(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
