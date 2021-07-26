import 'package:flutter/material.dart';
import 'package:recipe_gram/screens/account/profile.dart';
import 'package:recipe_gram/screens/feed.dart';
import 'package:recipe_gram/screens/recipe/new_recipe.dart';
import 'package:recipe_gram/screens/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    FeedPage(),
    SearchPage(),
    NewRecipePage(),
    ProfilePage()
  ];

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
        children: _pages,
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
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          hintText: "Search",
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              borderSide: const BorderSide(color: Colors.grey)),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: Colors.blue),
          ),
          hintStyle: TextStyle(color: Colors.black12),
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

  void _onItemTapped(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }
}
