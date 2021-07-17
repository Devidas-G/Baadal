import 'package:baadal/Services/DatabaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Global variables.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 1,
                cursorColor: Colors.grey[600],
                onChanged: (val){
                  setState(() {
                    search = val;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[350],
                  filled: true,
                  hintText: "Search",
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 0.01)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey,width: 0.01)
              ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 0.01)
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 0.01)
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 0.01)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 0.01)
                  ),
                ),
              ),
            ),
            StreamBuilder(
                stream: DatabaseServices().userFiles.where("name",isEqualTo: search).snapshots(),
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(search.isNotEmpty){
                switch (snapshot.connectionState){
                  case ConnectionState.none:
                    return Text("Loading .");

                  case ConnectionState.waiting:
                    return Text("Loading . .");

                  case ConnectionState.active:
                    if(snapshot.data!.docs.isEmpty){
                      return Text("User not found");
                    }
                    return Expanded(
                      child: Container(
                        //color: Colors.orange,
                        child: ListView(
                          children: snapshot.data!.docs.map((docs) => ListTile(
                            onTap: (){},
                            title: Row(
                              children: [
                                Container(
                                  height: size.height*0.07,
                                  width: size.width*0.14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(90))
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    child: docs['profileUrl']==null?Image.asset("images/Default-Profile.png"):
                                    Image.network(
                                      docs['profileUrl'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(docs['name'],style: TextStyle(
                                  fontSize: 20,
                                  color: myColor,
                                )),
                                Text(docs['email'],style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700]
                                ),)
                              ],
                            ),
                              ],
                            ),
                          )).toList(),
                        ),
                      ),
                    );

                  case ConnectionState.done:
                    // TODO: Handle this case.
                    break;
                }
              }
              return Text("Search for users");
            })
          ],
        ),
      ),
    );
  }
}
