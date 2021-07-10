import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
AuthService(this.auth);
FirebaseAuth auth;
Stream<User?> get authStateChanges => auth.authStateChanges();
}