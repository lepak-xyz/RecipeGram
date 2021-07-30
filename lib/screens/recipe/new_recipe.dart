import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recipe_gram/providers/user_provider.dart';
import 'package:recipe_gram/utilities/repgram-theme.dart';

class NewRecipePage extends StatefulWidget {
  NewRecipePage({Key? key}) : super(key: key);

  @override
  NewRecipePageState createState() => NewRecipePageState();
}

class NewRecipePageState extends State<NewRecipePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController captionController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController ingredientsController = new TextEditingController();
  TextEditingController instructionsController = new TextEditingController();
  final ImagePicker _picker = ImagePicker();

  XFile? image;

  Widget showImage() {
    return Container(
      color: Colors.white,
      child: FlatButton(
        onPressed: () async {
          final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            setState(() {
              image = pickedFile;
            });
          }
        },
        child: image != null
            ? Image.file(File(image!.path))
            : Stack(
                children: [
                  Image.asset(
                    'assets/choose-image.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.add_circle),
                  ),
                ],
              ),
      ),
    );
  }

  Widget TagSection() {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tag',
            style: TextStyle(fontWeight: FontWeight.bold, color: RepGramColor.primary, fontSize: 18.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          // TODO
          // Add ListView
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                OutlineButton(
                  onPressed: () {},
                  child: Text("Western"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void share() {
    if (_formKey.currentState!.validate()) {
      if (image != null) {
        Fluttertoast.showToast(msg: "Loading...");
        context.read<UserProvider>().setBusyState(true);

        context
            .read<UserProvider>()
            .createPost(
              image!,
              captionController.text,
              nameController.text,
              ingredientsController.text,
              instructionsController.text,
            )
            .then((flag) {
          if (flag) {
            setState(() {
              captionController.text = "";
              nameController.text = "";
              ingredientsController.text = "";
              instructionsController.text = "";
              image = null;
            });

            Fluttertoast.showToast(msg: "Your recipe has been successfully posted!");
            context.read<UserProvider>().setBusyState(false);
          }
        });
      } else {
        Fluttertoast.showToast(msg: "Please select an image.");
      }
    }
  }

  String? validate(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                height: 120,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: showImage(),
                      flex: 33,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          validator: validate,
                          controller: captionController,
                          maxLines: 5,
                          maxLength: 60,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a caption... (max: 60)',
                            isDense: true,
                          ),
                        ),
                      ),
                      flex: 66,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              // TODO
              // TAG SECTION & DIVIDER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Recipe Name',
                      style: TextStyle(fontWeight: FontWeight.bold, color: RepGramColor.primary, fontSize: 18.0),
                    ),
                    TextFormField(
                      validator: validate,
                      controller: nameController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'What is your secret recipe name?',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ingredients',
                      style: TextStyle(fontWeight: FontWeight.bold, color: RepGramColor.primary, fontSize: 18.0),
                    ),
                    TextFormField(
                      validator: validate,
                      controller: ingredientsController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Tell us your secret ingredients... (separate by using new line)',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Instructions',
                      style: TextStyle(fontWeight: FontWeight.bold, color: RepGramColor.primary, fontSize: 18.0),
                    ),
                    TextFormField(
                      validator: validate,
                      controller: instructionsController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Tell us your magical touch... (separate by using new line)',
                      ),
                    ),
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
