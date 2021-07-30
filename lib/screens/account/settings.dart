import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_gram/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // TODO
  // Disable textform when in loading state

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _bioController = new TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> logout() async {
    context.read<UserProvider>().logout().then((flag) {
      if (flag) {
        Fluttertoast.showToast(msg: "You have been successfully logged out.", toastLength: Toast.LENGTH_LONG);
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    });
  }

  Future<void> updateProfile() async {
    Fluttertoast.showToast(
        msg: "Loading...");

    context
        .read<UserProvider>()
        .updateProfile(
          _nameController.text,
          _usernameController.text,
          _bioController.text,
        )
        .then(
      (flag) {
        if (flag) {
          Fluttertoast.showToast(
              msg: "Your profile has been successfully updated.");
        } else {
          Fluttertoast.showToast(
              msg: "Failed to update profile.");
        }
      },
    );
  }

  chooseImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        context.read<UserProvider>().updatePhoto(pickedFile).then((flag) {
          if (flag) {
            Fluttertoast.showToast(
                msg: "Profile photo has been successfully updated.");
          }
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = context.read<UserProvider>().user!.fullName;
    _usernameController.text = context.read<UserProvider>().user!.username;
    _bioController.text = context.read<UserProvider>().user!.bio;
  }

  /*
  *
  * WIDGET
  *
   */
  Widget showImage() {
    return CircleAvatar(
      backgroundImage: context.watch<UserProvider>().user!.profileImgUrl != ""
          ? NetworkImage(context.watch<UserProvider>().user!.profileImgUrl)
          : AssetImage("assets/no-profile.png") as ImageProvider,
      radius: 60,
      backgroundColor: Colors.red,
    );
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
              showImage(),
              TextButton(
                onPressed: chooseImage,
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
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Full Name',
                            ),
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
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: "Username",
                            ),
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
                          child: TextFormField(
                            controller: _bioController,
                            maxLines: 4,
                            maxLength: 60,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Biodata [max: 60]',
                            ),
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
