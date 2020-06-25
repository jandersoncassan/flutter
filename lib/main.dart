import 'package:carros/bloc/favoritos_bloc.dart';
import 'package:carros/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final favoritosBloc = FavoritosBloc();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FavoritosBloc>(
          create: (context) => FavoritosBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light, //default ligth nem precisa setar
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashPage(),
      ),
    );
  }
}
