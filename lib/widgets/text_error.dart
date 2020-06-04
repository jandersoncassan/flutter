import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  String message;
  Function onpressed;

  TextError({this.message, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onpressed,
        child: Text(
          message,
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
      ),
    );
  }
}
