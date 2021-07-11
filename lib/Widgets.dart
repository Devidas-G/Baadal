import 'package:flutter/material.dart';
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.textEditingController,
    required this.darkMode,required this.icon, required this.themeColor, required this.hint, required this.obscure,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final bool darkMode;
  final IconData icon;
  final Color themeColor;
  final String hint;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30,right: 30),
      child: TextFormField(
        controller: textEditingController,
        cursorColor: themeColor,
        style: TextStyle(color: darkMode?Colors.grey:Colors.black),
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: themeColor,),
          hintText: "$hint",
          hintStyle: TextStyle(color: Colors.grey[600]),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkMode?Colors.grey:Colors.black)),
        ),
      ),
    );
  }
}


class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key, required this.color, required this.text, required this.onTap,
  }) : super(key: key);

  final Color color;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          onTap:()=>onTap(),
          child: Center(child: Text("$text",style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),)),
        ),
      ),
    );
  }
}