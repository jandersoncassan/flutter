import 'package:flutter/material.dart';

Text text(String nome, {double fontSize = 16, color = Colors.black, bold = false}) {
  return Text(
    nome ?? "",
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
