import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
var myColor = const Color(0xff3d4ebc); //blue color
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
String search="";
final form = GlobalKey<FormState>();
bool eyeObscure=true;
User? user = FirebaseAuth.instance.currentUser;
PageController pageController= PageController();
List<UploadTask> uploadTasks = [];
late UploadTask uploadTask;