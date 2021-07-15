import 'package:baadal/Services/AuthServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Global variables.dart';
import '../Widgets.dart';

class LogInPage extends StatefulWidget {
  final Function toggleView;
  final bool darkMode;

  const LogInPage({Key? key, required this.toggleView, required this.darkMode})
      : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String error="";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.darkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(color: myColor, fontSize: 40),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AuthTextField(
                      textEditingController: email,
                      darkMode: widget.darkMode,
                      icon: Icons.email,
                      themeColor: myColor,
                      hint: "Email",
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please Enter Email";
                        }
                      },
                      onChanged: (val){
                        setState(() {
                          error="";
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AuthTextField(
                      textEditingController: password,
                      darkMode: widget.darkMode,
                      icon: Icons.lock,
                      themeColor: myColor,
                      hint: "Password",
                      obscure: eyeObscure,
                      eyeIcon: true,
                      onEyePressed: () {
                        setState(() {
                          eyeObscure = !eyeObscure;
                        });
                      },
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please Enter Password";
                        }else if(text.length<6){
                          return "Password must be greater than 5";
                        }
                      },
                      onChanged: (val){
                        setState(() {
                          error="";
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("$error",style: TextStyle(
                        color: Colors.red,
                        fontSize: 14
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    AuthButton(
                        color: myColor,
                        text: "Login",
                        onTap: () async {
                          if (form.currentState!.validate()) {
                            print("${email.text},${password.text}");
                            setState(() {
                              error="";
                            });
                            dynamic result = await AuthService(FirebaseAuth.instance).emailLogIn(email.text, password.text);
                            if(result!=UserCredential){
                              setState(() {
                                error=result;
                              });
                            }
                          }
                        }),
                    Padding(
                      padding: EdgeInsets.only(top:20.0,left: 40.0,right: 40.0,bottom: 20.0),
                      child: Container(
                        color: Colors.black,
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                    SocialAuthBtn(imagePath: 'images/Google-Logo.png',onTap: ()async{
                      AuthService(FirebaseAuth.instance).signInWithGoogle();
                    },),
                  ],
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                widget.toggleView();
              },
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                      fontFamily: 'Segoe UI',
                      color: Colors.grey[600],
                      fontSize: 20),
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