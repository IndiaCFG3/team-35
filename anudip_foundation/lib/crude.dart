import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class CrudeMethods {
  Future uploadData(mapData)async {
    await Firestore.instance.collection('ImageCollection').add(mapData).catchError((e){
      print(e);
    });
  }
  Future getData() async
  {
    return await Firestore.instance.collection("students").snapshots();
  }
  Future getImageData() async
  {
    return await Firestore.instance.collection("ImageCollection").snapshots();
  }
  getSearchedData(String searchField) async {
    searchField = searchField.trim();
    return await Firestore.instance.collection(
        "students").where('uid', isEqualTo: searchField).snapshots();
  }
  Future<dynamic> getUserId() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }
  Future<String> getUserEmail() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.email;
    return uid.toString();
  }
}
