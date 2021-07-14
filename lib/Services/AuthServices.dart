import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
AuthService(this.auth);
FirebaseAuth auth;
Stream<User?> get authStateChanges => auth.authStateChanges();

Future emailLogIn(email,password)async{
  try{
    UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }on FirebaseAuthException catch(e){
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return "No user found";
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return "Wrong password";
    }else if(e.code=='invalid-email'){
      print("enter a valid email");
      return "enter a valid email";
    }else if(e.code=='unknown'){
      print('please fill all the details');
      return 'please fill all the details';
    }else{
      print(e.code);
      print(e.message);
      print(e);
      return e.message;
    }
  }catch(e){
    print(e.toString());
  }
// End of Function
}

Future signup(String email,String password) async {
  try{
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return  userCredential;
  }on FirebaseAuthException catch(e){
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return e.message;
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return e.message;
    }else if(e.code=='unknown'){
      print('please fill all the details');
      return 'please fill all the details';
    }else{
      return e.message;
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
  return userCredential;
}

Future logout() async {
  auth.signOut();
}
//End of class
}