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
  String getImageIcon(type){
    return "images/FilesIcon.png";
  }
  bool isImage(type){
    switch(type){
      case "jpg":
        return true;
      case "JPEG":
        return true;
    }
    return false;
  }
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
                              title: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    //color: Colors.black,
                                    child: isImage(doc['type'])?Image.network(doc['url'],fit: BoxFit.cover,):Image.asset(getImageIcon(doc["type"])),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc['name'],
                                          style: TextStyle(
                                            color: myColor,
                                          ),
                                          maxLines: 1,
                                        ),
                                        Text(
                                          "Download",
                                          style: TextStyle(
                                              color: Colors.blue[700],
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: myColor,
                                      size: 40,
                                    ),
                                    onPressed: () async {
                                      await DatabaseServices().deleteDoc(doc['name']);
                                      print("deleted");
                                    },
                                  )
                                ],
                              ),
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
