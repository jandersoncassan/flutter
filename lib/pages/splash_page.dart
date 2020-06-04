import 'package:carros/dao/db_helper.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget{
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
 
 @override
  void initState() {
    Future.delayed(Duration(seconds: 15), (){
      push(context, LoginPage());
    });

    Future dataBase= DatabaseHelper.getInstance().db;
    Future.delayed(Duration(seconds: 2));
    Future<Usuario> user = Usuario.get();
    Future.wait([dataBase, user]).then((List futures) {
        Usuario user = futures[1];
        if(user != null){
         print('Usuario logado : $user');
         push(context, HomePage(), replace: true);
      } else{
         push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}