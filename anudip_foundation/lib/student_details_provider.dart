import 'package:anudip_foundation/Welcome/components/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:anudip_foundation/components/rounded_input_field.dart';
import 'package:anudip_foundation/components/rounded_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'crude.dart';
class StudentDetailsProvider extends StatefulWidget {
  @override
  _StudentDetailsProviderState createState() => _StudentDetailsProviderState();
}

class _StudentDetailsProviderState extends State<StudentDetailsProvider> {
  final auth = FirebaseAuth.instance;
  final firestore = Firestore.instance;
  String course;
  String region;
  String studentName;
  String description;
  alert({BuildContext context,String title,String desc}) {
    return Alert(
        context: context,
        title: "$title",
        desc: "$desc")
        .show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(
                hintText: "Course",
                onChanged: (value) {
                  course = value;
                },
              ),
              RoundedInputField(
                hintText: 'Region',
                onChanged: (value) {
                  region = value;
                },
              ),
              RoundedInputField(
                hintText: 'Student Name',
                onChanged: (value) {
                  studentName = value;
                },
              ),

              RoundedInputField(
                hintText: 'Description',
                onChanged: (value) {
                  description = value;
                },
              ),
              RoundedButton(
                text: "SUBMIT",
                press: ()async{
                  CrudeMethods objcrude = CrudeMethods();
                  String uid=await  objcrude.getUserId();
                  bool b = false;
                  try{
                    firestore.collection('students').add(
                        {
                          'course':course,
                          'description':description,
                          'region':region,
                          'studentName':studentName,
                          'uid':uid,
                        }
                    );
                  }catch(e)
                  {
                    b=true;
                    print(e);
                  }
                  if(b){
                    alert(context: context,desc: 'Student Data not uploaded',title: 'unsuccessful');
                  }
                  else
                  {
                    alert(context: context,desc: 'Student Data uploaded',title: 'successful');

                  }
                },              )
            ],
          ),
        ),
      ),
    );
  }
}
