import 'package:baadal/Global%20variables.dart';
import 'package:baadal/Services/DatabaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({Key? key}) : super(key: key);

  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              //AppBar
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(0, 3), blurRadius: 6)
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "root/",
                                style: TextStyle(color: myColor, fontSize: 24),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Directory"),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        //TODO: copy button onTap
                      },
                      icon: Icon(
                        Icons.copy,
                        color: myColor,
                      ))
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder(
                stream: DatabaseServices().userFiles.doc(user!.uid).collection('userFiles').orderBy('time').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading'));
                } else if (snapshot.data!.docs.isEmpty) {
                  //print(snapshot.data.documents);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/BlueCloud.png",height: 150,),
                      Text("No file is your cloud drive"),
                    ],
                  );
                }
                return ListView(
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data!.docs
                        .map((doc) => ListTile(
                              title: Row(),
                            ))
                        .toList());
              },
            )),
          ],
        ),
      ),
    );
  }
}
