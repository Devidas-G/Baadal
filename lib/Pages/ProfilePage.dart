import 'package:baadal/Global%20variables.dart';
import 'package:baadal/Services/AuthServices.dart';
import 'package:baadal/Services/DatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    bool heightGreater = size.height > size.width ? true : false;
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 55,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Profile",style: TextStyle(color: myColor,fontSize: 22,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              FutureBuilder(
                  future: DatabaseServices().getUserInfo(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> snapshot) {
                    return InkWell(
                      onTap: (){
                        //TODO: Navigate to edit profile
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: heightGreater ? size.height * 0.1 : size
                                  .height * 0.2,
                              width: heightGreater ? size.width * 0.2 : size
                                  .width * 0.1,
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
                                          borderRadius: BorderRadius.circular(90),
                                          child:
                                          Image.network(
                                            '${data['profileUrl']}',
                                            fit: BoxFit.cover,
                                          )
                                      );
                                }
                                return Image.asset("images/Default-Profile.png");
                              }()),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(bottom: 40,left: 10),
                                    child: (() {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return Text("Loading UserName...");
                                        case ConnectionState.waiting:
                                          return Text("Loading UserName...");
                                        case ConnectionState.active:
                                          return Text("Loading UserName...");
                                        case ConnectionState.done:
                                          Map<String, dynamic> data = snapshot
                                              .data;
                                          if ({data['name']}.isEmpty) {
                                            return Text(
                                              "Enter name",
                                              style: TextStyle(
                                                  fontSize: 18, color: myColor),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                              "Loading UserName...",
                                              style: TextStyle(
                                                  fontSize: 18, color: myColor),
                                            );
                                          } else if (data['name'] == null) {
                                            return Text(
                                              "Enter name",
                                              style: TextStyle(
                                                  fontSize: 18, color: myColor),
                                            );
                                          } else if (data['name'] == "") {
                                            return Text(
                                              "Enter name",
                                              style: TextStyle(
                                                  fontSize: 18, color: myColor),
                                            );
                                          } else if ({data['name']}.isNotEmpty) {
                                            return Text(
                                              "${data['name']}",
                                              style: TextStyle(
                                                  fontSize: 24, color: myColor),
                                            );
                                          }
                                      }
                                      Text(
                                        "Loading UserName...",
                                      );
                                    }()), )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_forward_ios,color: myColor,),
                          ),
                        ],
                      ),
                    );
                  }),
              InkWell(
                onTap: () {
                  AuthService(FirebaseAuth.instance).logout();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(Icons.logout, color: myColor, size: 30,),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Logout",
                      style: TextStyle(color: myColor, fontSize: 18),),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
