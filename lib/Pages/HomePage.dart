import 'package:baadal/Services/AuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage(bool darkMode, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: RaisedButton(
        child: Text("Log out"),
        onPressed: ()async{
          await AuthService(FirebaseAuth.instance).logout();
        },
      ),
    );
  }
}
