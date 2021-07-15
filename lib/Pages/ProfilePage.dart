import 'package:baadal/Global%20variables.dart';
import 'package:baadal/Services/DatabaseServices.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          FutureBuilder(
              future: DatabaseServices().getUserInfo(),
              builder: (BuildContext context,
              AsyncSnapshot<dynamic> snapshot) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.height * 0.1,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                      //color: Colors.green,
                        borderRadius:
                        BorderRadius.all(Radius.circular(90))),
                    child: ((){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                          return Image.asset("images/Default-Profile.png");
                        case ConnectionState.waiting:
                          return Image.asset("images/Default-Profile.png");
                        case ConnectionState.active:
                          return Image.asset("images/Default-Profile.png");
                        case ConnectionState.done:
                          Map<String, dynamic> data = snapshot.data;
                          if({data['profileUrl']}.isEmpty)
                            return Image.asset("images/Default-Profile.png");
                          if(snapshot.hasError)
                            return Image.asset("images/Default-Profile.png");
                          if(data['profileUrl']==null)
                            return Image.asset("images/Default-Profile.png");
                          if({data['profileUrl']}.isNotEmpty)
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
              ],
            );
          }),
        ],
      ),
    ));
  }
}
