import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          actions: [
            TextButton(
                onPressed: () {
                  // TODO
                  // Save data
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Successfully updated your profile.')));
                  Navigator.pop(context);
                },
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
                      ElevatedButton(
                        onPressed: () {
                          // TODO
                          // Tag Settings
                        },
                        child: Text("Tag Settings"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // TODO
                          // Logout Function
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                        child: Text("Logout"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        )

        /*
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
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
                  Divider(color: Colors.black,),
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text("Name", style: TextStyle(color: Colors.black, fontSize: 14),),
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
                              child: Text("Username", style: TextStyle(color: Colors.black, fontSize: 14),),
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
                          children: [
                            Expanded(
                              child: Text("Bio", style: TextStyle(color: Colors.black, fontSize: 14),),
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Bottom Button
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Divider(
                    color: Colors.black,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO
                      // Tag Settings
                    },
                    child: Text("Tag Settings"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO
                      // Logout Function
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    child: Text("Logout"),
                  )
                ],
              ),
            )
          ],

        )
                     */
        );
  }
}
