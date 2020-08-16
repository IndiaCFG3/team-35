import 'package:anudip_foundation/Welcome/welcome_screen.dart';
import 'package:anudip_foundation/om_visit_page.dart';
import 'package:anudip_foundation/posts.dart';
import 'package:anudip_foundation/student_details.dart';
import 'package:anudip_foundation/student_details_provider.dart';
import 'package:anudip_foundation/upload_image.dart';
import 'package:anudip_foundation/visit_page.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anudip_Organization',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
