import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/screens/account/profile.dart';
import 'package:recipe_gram/screens/feed.dart';
import 'package:recipe_gram/screens/recipe/new_recipe.dart';
import 'package:recipe_gram/screens/search.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_gram/utilities/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  String searchText = "";
  late List<Recipe> recipeSearched = <Recipe>[];
  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _selectedIndex != 1
            ? const Text('RecipeGram')
            : _buildSearchField(),
        actions: _buildActions(),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          FeedPage(),
          SearchPage(recipeList: recipeSearched),
          NewRecipePage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.redAccent,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), label: "Post New Recipe"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_rounded), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      autofocus: false,
      controller: _searchController,
      onEditingComplete: () {
        setState(() {
          searchText = _searchController.text;
        });
        search();
      },
      decoration: InputDecoration(
          hintText: "Search",
          filled: true,
          fillColor: Color.fromRGBO(253, 223, 223, 1),
          border: UnderlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          hintStyle: TextStyle(color: Colors.black38),
          prefixIcon: new Icon(Icons.search, color: Colors.grey)),
      style: TextStyle(color: Colors.black, fontSize: 16.0),
    );
  }

  List<Widget> _buildActions() {
    if (_selectedIndex == 2) {
      return <Widget>[
        TextButton(onPressed: () {}, child: Text("Share", style: TextStyle(color: Colors.blue[300]),))
      ];
    }

    return <Widget>[];
  }

  void search() async {
    if (searchText.isNotEmpty) {
      final response = await http.get(Uri.parse(Utils.apiHost + "/recipe/$searchText"));
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] != null && jsonResponse['status'] == 200) {
        final data = jsonResponse['data'] as List;

        setState(() {
          recipeSearched = data.map<Recipe>((item) => Recipe.fromJson(item)).toList();
        });
      } else {
        Fluttertoast.showToast(msg: "Server error. Please contact admin.");
      }
    }
  }

  void _onItemTapped(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }
}
