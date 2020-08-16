import 'dart:io';
import 'package:anudip_foundation/Welcome/welcome_screen.dart';
import 'package:anudip_foundation/posts.dart';
import 'package:anudip_foundation/student_details.dart';
import 'package:anudip_foundation/student_details_provider.dart';
import 'package:anudip_foundation/upload_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anudip_foundation/components/rounded_button.dart';
import 'package:anudip_foundation/components/rounded_input_field.dart';
import 'package:anudip_foundation/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:anudip_foundation/crude.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Login/components/background.dart';
class VisitPage extends StatefulWidget {
  @override
  _VisitPageState createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  String query;
  var auth = Firestore.instance;
  alert({BuildContext context,String title,String desc}) {
    return Alert(
        context: context,
        title: "$title",
        desc: "$desc")
        .show();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryLightColor,
          elevation: 1,
          leading: GestureDetector(
            onTap: (){
              var authTemp = FirebaseAuth.instance;
              authTemp.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen()));
              },
            child: Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Background(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ButtonVisitPage(
                  text: 'STUDENT DETAILS',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StudentDetails()));
                  }
                ),
                ButtonVisitPage(
                    text:'ADD STUDENT',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => StudentDetailsProvider()));
                    }
                ),
                ButtonVisitPage(
                  text:'UPLOAD IMAGE',
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UploadImage()));
                  },
                ),
                ButtonVisitPage(
                  text:'POSTS',
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Posts()));
                  },
                ),
                ButtonVisitPage(
                  text: 'TARGET',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ButtonVisitPage extends StatelessWidget {
  final Function onTap;
  final String text;
  const ButtonVisitPage({Key key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 60,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text.toString(),
            style: TextStyle(
                color: kPrimaryLightColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
