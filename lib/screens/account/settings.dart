import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_gram/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await _prefs;

    prefs.remove("token").then((value) => () {
      prefs.remove("user");
      Fluttertoast.showToast(msg: "You have been successfully logged out.", toastLength: Toast.LENGTH_LONG);
    }).onError((error, stackTrace) => () {
      Fluttertoast.showToast(msg: "An error has been occurred. [${error.toString()}]", toastLength: Toast.LENGTH_LONG);
    });

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<void> updateProfile() async {
    UserProvider.updateProfile().then((value) => () {
      Fluttertoast.showToast(msg: "Your profile has been successfully updated.");
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          TextButton(
              onPressed: updateProfile,
              child: Text(
                "Done",
                style: TextStyle(color: Colors.blue[300], fontSize: 16.0),
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.asset(
                  'assets/profile.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.fill,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Change profile photo",
                  style: TextStyle(color: Colors.blue[800]),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Name",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          flex: 33,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Ali Abu'),
                          ),
                          flex: 76,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Username",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          flex: 33,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: '@aliabu'),
                          ),
                          flex: 76,
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Bio",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          flex: 33,
                        ),
                        Expanded(
                          child: TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: '@aliabu'),
                          ),
                          flex: 76,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(
                      color: Colors.black,
                    ),
                    /*
                    ElevatedButton(
                      onPressed: () {
                        // TODO
                        // Tag Settings
                      },
                      child: Text("Tag Settings"),
                    ),
                     */
                    ElevatedButton(
                      onPressed: logout,
                      child: Text("Logout"),
                    )
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
