import 'dart:async';

import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/services/api_response.dart';
import 'package:carros/services/login_api.dart';

class LoginBloc extends SimpleBloc<bool> {
  
  Future<ApiResponse<Usuario>> fetch(String email, String password) async {
    add(true);
    ApiResponse<Usuario> response = await LoginApi.login(email, password);
    add(false);
    return response;
  }
}
