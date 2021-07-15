import 'package:cloud_firestore/cloud_firestore.dart';

import '../Global variables.dart';
class DatabaseServices {
  CollectionReference userFiles = FirebaseFirestore.instance.collection('users');
Future getUserInfo() async {
  return await userFiles.doc(user!.uid).get().then((value){
    if(value.exists){
      return value.data();
    }else{
      userFiles.doc(user!.uid).set({
        "email":user!.email,
        "uid":user!.uid,
        "profileUrl":null,
        "name":user!.displayName
      }).whenComplete(() {return  value.data();});
    }
  });

}
}
