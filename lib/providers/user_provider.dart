import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/models/user_model.dart';
import 'package:recipe_gram/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  User? user;
  List<Recipe> favourite = [];
  List<Recipe> posts = [];
  bool auth = false;
  bool _isBusy = false;

  void setBusyState(bool flag) {
    this._isBusy = flag;
    notifyListeners();
  }

  bool isBusy() {
    return _isBusy;
  }

  Future<bool> isLoggedIn() async {
    return await UserService.checkToken(this);
  }

  Future<bool> login(String username, String password) async {
    return await UserService.login(username, password, this);
  }

  Future<bool> register(String email, String username, String password, String phone) async {
    return await UserService.register(email, username, password, phone, this);
  }

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var flag = false;

    await prefs.remove("token");
    this.favourite.clear();
    this.posts.clear();
    this.auth = false;
    flag = true;

    notifyListeners();
    //Fluttertoast.showToast(msg: "An error has been occurred. [${error.toString()}]", toastLength: Toast.LENGTH_LONG);

    return flag;
  }

  Future<bool> updateProfile(String name, String username, String bio) async {
    return await UserService.updateProfile(name, username, bio, this);
  }

  Future<bool> updatePhoto(XFile file) async {
    return await UserService.updatePhoto(file, this);
  }

  Future<bool> createPost(XFile picture, String caption, String name, String ingredients, String instructions) async {
    return await UserService.addPosts(picture, caption, name, ingredients, instructions, this);
  }

  Future<bool> addOrRemoveFavourite(Recipe rep) async {
    if (favourite.contains(rep)) {
      return await removeFromFavourite(rep);
    } else {
      return await addToFavourite(rep);
    }
  }

  Future<bool> addToFavourite(Recipe rep) async {
    return await UserService.addToFavourite(rep, this);
  }

  Future<bool> removeFromFavourite(Recipe rep) async {
    return await UserService.removeFromFavourite(rep, this);
  }

  Future<bool> heatRecipe(Recipe rep) async {
    var flag = await UserService.heatRecipe(rep, user!.heats.contains(rep.id), this);
    notifyListeners();

    return flag;
  }

  Future<bool> isAuth() async {
    return auth;
  }

  Future<void> getUserExtraInfo() async {
    await UserService.getPosts(this);
    await UserService.getFavourites(this);

    notifyListeners();
  }

  User? getCurrentUser() {
    return user;
  }

  List<Recipe> getUserFavourites() {
    return favourite;
  }

  List<Recipe> getUserPosts() {
    return posts;
  }
}
