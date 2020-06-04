import 'dart:async';

import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/services/login_api.dart';
import 'package:carros/services/response_api.dart';

class LoginBloc extends SimpleBloc<bool> {
  
  Future<ResponseApi<Usuario>> fetch(String email, String password) async {
    add(true);
    ResponseApi<Usuario> response = await LoginApi.login(email, password);
    add(false);
    return response;
  }
}
