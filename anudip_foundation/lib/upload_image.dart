import 'dart:io';

import 'package:anudip_foundation/Login/components/background.dart';
import 'package:anudip_foundation/components/rounded_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anudip_foundation/Welcome/welcome_screen.dart';
import 'package:anudip_foundation/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:anudip_foundation/crude.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File imageFile;
  String number;
  String dateVar, placeVar;
  var user = "";
  final picker = ImagePicker();
  final auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  bool _loadingScreen = false;
  Future<void> uploadData() async {
    if (imageFile != null) {
      setState(() {
        _loadingScreen = true;
      });
      StorageReference firebaseRef = FirebaseStorage.instance
          .ref()
          .child('Images')
          .child('${randomAlphaNumeric(9)}.jpg');
      final StorageUploadTask task = firebaseRef.putFile(imageFile);
      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      Map<String, String> mapVar = {
        'date': dateVar,
        'place': placeVar,
        'url': downloadUrl,
      };
      CrudeMethods crudeObj = CrudeMethods();
      crudeObj.uploadData(mapVar).then((result) {
        print('done');
        print('user is $user');
        alert(context);
        setState(() {
          dateVar = '';
          placeVar = '';
        });
      });
    }
  }


  alert(BuildContext context) {
    return Alert(
        context: context,
        title: "Successful",
        desc: "Image uploaded Successfully")
        .show();
  }

  void setUserName() async {
    try {
      FirebaseUser user1 = await auth.currentUser();
      if (user1 != null) {
        loggedInUser = user1;
        setState(() {
          user = loggedInUser.email.toString();
        });
        print(user);
        print('the above is user name');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: FlatButton(
              child: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          resizeToAvoidBottomPadding: false,
          body: SingleChildScrollView(
            child: Background(
              child: Container(
                // margin: EdgeInsets.only(top:10),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: imageFile != null
                          ? Container(
                        margin: EdgeInsets.all(14),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: double.infinity,
                            height:
                            MediaQuery.of(context).size.height * 0.35,
                            child: Image.file(
                              imageFile,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                          : Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(14),
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimaryLightColor,
                        ),
                        child: Icon(
                          Icons.add_a_photo,
                          size: 28,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),

                        child: RoundedInputField(
                          hintText: 'Date',
                          icon: Icons.calendar_today,
                          onChanged: (value){
                            setState(() {
                              dateVar=value;
                            });
                          },
                        ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: RoundedInputField(
                        hintText: 'Place',
                        icon: Icons.place,
                        onChanged: (value) {
                          setState(() {
                            placeVar = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 30),
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              onPressed: () {
                uploadData();
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Icon(Icons.add),
              ),
            ),
          )),
    );
  }
}
