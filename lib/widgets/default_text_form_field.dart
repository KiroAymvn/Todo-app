import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  Widget suffixIcon;
  String? Function(String?) valid;
  TextInputType keyboard;
  GestureTapCallback ?onTap;

  DefaultTextFormField({super.key,
    required this.controller,
    required this.hint,
  required this.suffixIcon,
  required this.valid,
  required this.keyboard,
   this.onTap});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller,
      validator:valid ,
      keyboardType:keyboard ,
      onTap: onTap,
      decoration: InputDecoration(
         enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: hint,
        hintStyle: TextStyle(
          color: Color(0xff57261A),

        ),
        suffixIcon: suffixIcon,
          suffixIconColor: Color(0xff57261A),
        fillColor: Color(0xffFBF8D9),
        filled: true,
        enabled: true,


      ),


    );
  }
}
