import 'package:baadal/Services/AuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Pages/HomePage.dart';
import 'Pages/LogInPage.dart';
import 'Pages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: false);
  runApp(MultiProvider(providers: [
    Provider(create: (_) => AuthService(FirebaseAuth.instance)),
    StreamProvider(
      create: (context) => context.read<AuthService>().authStateChanges,
      initialData: null,
    )
  ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper())));
}

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final user = context.watch<User?>();
    if (user != null) {
      return HomePage(darkMode);
    } else {
      if (showSignIn) {
        return LogInPage(toggleView: toggleView, darkMode: darkMode,);
      } else {
        return SignUpPage(toggleView: toggleView,darkMode: darkMode);
      }
    }
  }
}
