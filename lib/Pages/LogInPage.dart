import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Global variables.dart';
class LogInPage extends StatefulWidget {
  final Function toggleView;
  final bool darkMode;
  const LogInPage({Key? key, required this.toggleView, required this.darkMode}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: widget.darkMode?Colors.black:Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login',style: TextStyle(
                          color: mycolor,
                          fontSize: 40
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email,color: mycolor,),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,color: mycolor,),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: mycolor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onTap: (){
                          print("${email.text},${password.text}");
                        },
                        child: Center(child: Text("Login",style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: (){
                widget.toggleView();
              },
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    color: Colors.grey[600],
                    fontSize: 20
                  ),
                  children: [
                    TextSpan(
                      text: "Don't have a account? ",
                    ),
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: const Color(0xff3d4ebc),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

