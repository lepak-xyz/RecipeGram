import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_gram/models/recipe_model.dart';
import 'package:recipe_gram/models/user_model.dart';
import 'package:recipe_gram/services/user_service.dart';

class UserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  User? user;
  List<Recipe> favourite = [];
  List<Recipe> posts = [];
  bool auth = false;

  Future<bool> isLoggedIn() async {
    return await UserService.checkToken(this);
  }

  Future<bool> login(String username, String password) async {
    return await UserService.login(username, password, this);
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

  Future<bool> isAuth() async {
    return auth;
  }

  void getUserExtraInfo() {
    UserService.getPosts(this);
    UserService.getFavourites(this);
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
