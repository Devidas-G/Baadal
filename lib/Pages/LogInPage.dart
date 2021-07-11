import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Global variables.dart';
import '../Widgets.dart';
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
      resizeToAvoidBottomInset: false,
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
                          color: myColor,
                          fontSize: 40
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AuthTextField(textEditingController: email, darkMode: widget.darkMode, icon: Icons.email, themeColor: myColor, hint: "Email",obscure: false,),
                  SizedBox(
                    height: 20,
                  ),
                  AuthTextField(textEditingController: password, darkMode: widget.darkMode, icon: Icons.lock, themeColor: myColor, hint: "Password",obscure: true,),
                  SizedBox(
                    height: 20,
                  ),
                  AuthButton(color: myColor, text: "Login", onTap: (){
                    print("${email.text},${password.text}");
                  })
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


