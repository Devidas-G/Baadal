import 'package:baadal/Global%20variables.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  AuthTextField({
    Key? key,
    required this.textEditingController,
    this.darkMode=false,
    required this.icon,
    required this.themeColor,
    required this.hint,
    this.obscure=false,
    this.validator,
    this.onChanged,
    this.eyeIcon=false,
    this.onEyePressed,
  }) : super(key: key);

  final TextEditingController textEditingController;
  bool darkMode;
  final IconData icon;
  final Color themeColor;
  final String hint;
  bool obscure;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;
  VoidCallback? onEyePressed;
  bool eyeIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
        controller: textEditingController,
        cursorColor: themeColor,
        style: TextStyle(color: darkMode ? Colors.grey : Colors.black),
        obscureText: obscure,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: themeColor,
          ),
          suffixIcon: eyeIcon
              ? IconButton(
            splashRadius: 1,
                  icon: Icon(Icons.remove_red_eye,color: eyeObscure?themeColor:Colors.grey,),
                  onPressed: onEyePressed,
                )
              : null,
          hintText: "$hint",
          hintStyle: TextStyle(color: Colors.grey[600]),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: darkMode ? Colors.grey : Colors.black)),
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.color,
    required this.text,
    required this.onTap,
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
          onTap: () => onTap(),
          child: Center(
              child: Text(
            "$text",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
      ),
    );
  }
}

class SocialAuthBtn extends StatelessWidget {
  const SocialAuthBtn({
    Key? key, required this.imagePath, this.onTap,
  }) : super(key: key);

  final String imagePath;
  final GestureTapCallback? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset("$imagePath"),
      ),
    );
  }
}
