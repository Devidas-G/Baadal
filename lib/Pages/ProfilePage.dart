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
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          FutureBuilder(
              future: DatabaseServices().getUserInfo(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(0,3),blurRadius: 6)],
                  ),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              width:70,
                              decoration: BoxDecoration(
                                //color: Colors.green,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(90))),
                              child: (() {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Image.asset("images/Default-Profile.png");
                                  case ConnectionState.waiting:
                                    return Image.asset("images/Default-Profile.png");
                                  case ConnectionState.active:
                                    return Image.asset("images/Default-Profile.png");
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
                                          child: Image.network(
                                            '${data['profileUrl']}',
                                            fit: BoxFit.cover,
                                          ));
                                }
                                return Image.asset("images/Default-Profile.png");
                              }()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 10),
                            child: (() {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return Text("Loading UserName...");
                                case ConnectionState.waiting:
                                  return Text("Loading UserName...");
                                case ConnectionState.active:
                                  return Text("Loading UserName...");
                                case ConnectionState.done:
                                  Map<String, dynamic> data = snapshot.data;
                                  if ({data['name']}.isEmpty) {
                                    return Text(
                                      "Enter name",
                                      style: TextStyle(fontSize: 18,color: myColor),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      "Loading UserName...",
                                      style: TextStyle(fontSize: 18,color: myColor),
                                    );
                                  } else if (data['name'] == null) {
                                    return Text(
                                      "Enter name",
                                      style: TextStyle(fontSize: 18,color: myColor),
                                    );
                                  }else if (data['name'] == "") {
                                    return Text(
                                      "Enter name",
                                      style: TextStyle(fontSize: 18,color: myColor),
                                    );
                                  } else if ({data['name']}.isNotEmpty) {
                                    return Text(
                                      "${data['name']}",
                                      style: TextStyle(fontSize: 18,color: myColor),
                                    );
                                  }
                              }
                              Text(
                                "Loading UserName...",
                              );
                            }()),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: (){
                              //TODO: Navigate to edit profile
                            }, icon: Icon(Icons.arrow_forward_ios,color: myColor,))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
          InkWell(
            onTap: (){
              AuthService(FirebaseAuth.instance).logout();
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Icon(Icons.logout,color: myColor,size: 30,),
                ),
                Text("Logout",style: TextStyle(color: myColor,fontSize: 18),),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
