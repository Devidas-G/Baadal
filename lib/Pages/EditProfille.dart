import 'package:baadal/Services/DatabaseServices.dart';
import 'package:baadal/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Global variables.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();

  TextEditingController about = TextEditingController();

  final nameKey = GlobalKey<FormState>();
  final aboutKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool heightGreater = size.height > size.width ? true : false;
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
          //Appbar
          height: 55,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: myColor,
                        )),
                  ],
                ),
              ),
              Text(
                "Edit profile",
                style: TextStyle(
                    color: myColor, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
        FutureBuilder(
            future: DatabaseServices().getUserInfo(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: heightGreater
                          ? size.height * 0.15
                          : size.height * 0.3,
                      width:
                          heightGreater ? size.width * 0.3 : size.width * 0.15,
                      decoration: BoxDecoration(
                          //color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(90))),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment(0, 0),
                            child: Container(
                              height: heightGreater
                                  ? size.height * 0.15
                                  : size.height * 0.3,
                              width: heightGreater
                                  ? size.width * 0.3
                                  : size.width * 0.15,
                              decoration: BoxDecoration(
                                  //color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90))),
                              child: (() {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Image.asset(
                                        "images/Default-Profile.png");
                                  case ConnectionState.waiting:
                                    return Image.asset(
                                        "images/Default-Profile.png");
                                  case ConnectionState.active:
                                    return Image.asset(
                                        "images/Default-Profile.png");
                                  case ConnectionState.done:
                                    Map<String, dynamic> data = snapshot.data;
                                    if ({data['profileUrl']}.isEmpty)
                                      return Image.asset(
                                          "images/Default-Profile.png");
                                    if (snapshot.hasError)
                                      return Image.asset(
                                          "images/Default-Profile.png");
                                    if (data['profileUrl'] == null)
                                      return Image.asset(
                                          "images/Default-Profile.png");
                                    if ({data['profileUrl']}.isNotEmpty)
                                      return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          child: Image.network(
                                            '${data['profileUrl']}',
                                            fit: BoxFit.cover,
                                          ));
                                }
                                return Image.asset(
                                    "images/Default-Profile.png");
                              }()),
                            ),
                          ),
                          Align(
                            alignment: Alignment(1, 1),
                            child: Container(
                                height: heightGreater
                                    ? size.height * 0.05
                                    : size.height * 0.1,
                                width: heightGreater
                                    ? size.width * 0.1
                                    : size.width * 0.05,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90))),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: myColor,
                                    ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: nameKey,
                      child: TextFormField(
                        controller: name,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please Enter Name";
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (nameKey.currentState!.validate()) {
                                DatabaseServices()
                                    .userFiles
                                    .doc(user!.uid)
                                    .update({
                                  'name': name.text,
                                }).whenComplete(() {
                                  FocusScope.of(context).unfocus();
                                  Fluttertoast.showToast(
                                    msg: "Name updated",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
                                });
                              }
                            },
                            icon: Icon(
                              Icons.check,
                              color: myColor,
                            ),
                          ),
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: myColor)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: aboutKey,
                      child: TextFormField(
                        controller: about,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please Enter Text";
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (aboutKey.currentState!.validate()) {
                                await DatabaseServices()
                                    .userFiles
                                    .doc(user!.uid)
                                    .update({
                                  'about': about.text,
                                }).whenComplete(() {
                                  FocusScope.of(context).unfocus();
                                  Fluttertoast.showToast(
                                    msg: "about updated",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
                                });
                              }
                            },
                            icon: Icon(
                              Icons.check,
                              color: myColor,
                            ),
                          ),
                          hintText: "About",
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: myColor)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })
      ],
    )));
  }
}
