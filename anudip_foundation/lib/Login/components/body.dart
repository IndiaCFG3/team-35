import 'package:anudip_foundation/Login/components/background.dart';
import 'package:anudip_foundation/Login/login_screen.dart';
import 'package:anudip_foundation/Welcome/welcome_screen.dart';
import 'package:anudip_foundation/visit_page.dart';
import 'package:flutter/material.dart';
import 'package:anudip_foundation/components/already_have_an_account_acheck.dart';
import 'package:anudip_foundation/components/rounded_button.dart';
import 'package:anudip_foundation/components/rounded_input_field.dart';
import 'package:anudip_foundation/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN FOR MOBILISER",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VisitPage();
                    }));
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),

          ],
        ),
      ),
    );
  }
}
