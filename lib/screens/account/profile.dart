import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_gram/providers/user_provider.dart';
import 'package:recipe_gram/screens/account/settings.dart';
import 'package:recipe_gram/widgets/recipe_grid_card.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);

    /*
    context.read<UserProvider>().isAuth().then((flag) {
      if (flag) {
        context.read<UserProvider>().getUserExtraInfo();
      }
    });

     */
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
    return context.watch<UserProvider>().getUserPosts().length > 0
        ? GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 3,
            children: context.watch<UserProvider>().getUserPosts().map(
              (recipe) {
                return RecipeGridView(recipe: recipe);
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
    return context.watch<UserProvider>().getUserFavourites().length > 0
        ? GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 3,
            children: context.watch<UserProvider>().getUserFavourites().map(
              (recipe) {
                return RecipeGridView(recipe: recipe);
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

  Widget ProfileHeader() {
    return SliverToBoxAdapter(
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
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: context
                          .watch<UserProvider>()
                          .getCurrentUser()!
                          .profileImgUrl
                          .isNotEmpty
                          ? NetworkImage(context
                          .watch<UserProvider>()
                          .getCurrentUser()!
                          .profileImgUrl)
                          : AssetImage("assets/no-profile.png") as ImageProvider,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${context.watch<UserProvider>().getUserPosts().length}",
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
                            "${context.watch<UserProvider>().getUserFavourites().length}",
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
                  context
                      .watch<UserProvider>()
                      .getCurrentUser()!
                      .username,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  context
                      .watch<UserProvider>()
                      .getCurrentUser()!
                      .bio !=
                      ""
                      ? context
                      .watch<UserProvider>()
                      .getCurrentUser()!
                      .bio
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
              ProfileHeader()
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
