import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String labelText;
  String hintText;
  TextEditingController controller;
  bool isPassword;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;
  // criamos esse parametro 'nextFocus' para controlar com estamos utilizando um TextFormField generico, precisamos dizer qual o proximo campo

  AppText(
    this.labelText,
    this.hintText, {
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null){
           FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        color: Colors.blue,
        fontSize: 20,
      ),
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(20)
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.green,
          fontSize: 13,
        ),
      ),
    );
  }
}
