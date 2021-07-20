import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:baadal/Global%20variables.dart';
import 'package:baadal/Services/DatabaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({Key? key}) : super(key: key);

  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  ReceivePort _port = ReceivePort();
  List types = ['jpg','jpeg','tif','tiff','bmp','gif','png'];
  /*@override
  void initState() {
    //causing unexpected app shutdown
    //TODO:Bug Fix
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

  }*/

  /*@override
  void dispose() {
    //causing unexpected app shutdown
    //TODO:Bug Fix
    _unbindBackgroundIsolate();
    super.dispose();

  }*/
  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];

    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  String getImageIcon(type){
    return "images/FilesIcon.png";
  }
  bool isImage(String type){
    if(types.contains(type)){
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
                                    child: isImage(doc['type'])?Image.network(doc['url'],fit: BoxFit.cover):Image.asset(getImageIcon(doc["type"])),
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
                                        InkWell(
                                          onTap: () async {
                                            final String dir =
                                                "/storage/emulated/0/Download";
                                            final String filedir= "$dir/${doc['name']}";
                                            if(await File(filedir).exists()){
                                              Fluttertoast.showToast(
                                                  msg: "File already exists in download folder",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                              );
                                            }else{
                                              //TODO: bug fix
                                              /*final status = await Permission
                                                  .storage
                                                  .request();
                                              if (status.isGranted) {

                                                await FlutterDownloader.enqueue(
                                                  url: doc['url'],
                                                  savedDir: dir,
                                                  showNotification: true,
                                                  openFileFromNotification:
                                                  true,
                                                  fileName: doc['name'],
                                                );
                                              }*/
                                            }
                                          },
                                          child: Text(
                                            "Download",
                                            style: TextStyle(
                                                color: Colors.blue[700],
                                                fontSize: 15),
                                          ),
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
