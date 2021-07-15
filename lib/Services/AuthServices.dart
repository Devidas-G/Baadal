import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Global variables.dart';

class AuthService{
AuthService(this.auth);
FirebaseAuth auth;
Stream<User?> get authStateChanges => auth.authStateChanges();

Future emailLogIn(email,password)async{
  try{
    UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    return userCredential;
  }on FirebaseAuthException catch(e){
    if(e.code=='unknown'){
      return 'An unknown error has occurred';
    }else{
      print(e.code);
      return e.code;
    }
  }catch(e){
    print(e.toString());
  }
// End of Function
}

Future signup(String email,String password) async {
  try{
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    return  userCredential;
  }on FirebaseAuthException catch(e){
    if(e.code=='unknown'){
      return 'An unknown error has occurred';
    }else{
      print(e.code);
      return e.code;
    }
  }catch (e) {
    print(e);
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  UserCredential userCredential =await FirebaseAuth.instance.signInWithCredential(credential);
  user = userCredential.user;
  return userCredential;
}

Future logout() async {
  auth.signOut();
}
//End of class
}