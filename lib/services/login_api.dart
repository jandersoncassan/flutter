import 'dart:convert';

import 'package:carros/models/usuario.dart';
import 'package:carros/services/response_api.dart';
import 'package:http/http.dart' as http;


class LoginApi {
  static Future<ResponseApi<Usuario>> login(String login, String senha) async {
    try {
      // var url = 'http://livrowebservices.com.br/rest/login';
      var url = 'http://carros-springboot.herokuapp.com/api/v2/login';
      //final params = {'login': login, 'senha': senha};

      //pode ter tipagem ou nao, é basicamente um json, no flutter map é um json
      Map<String, String> params = {'username': login, 'password': senha};

      //pode ter tipagem ou nao, é basicamente um json, no flutter map é um json
      Map<String, String> headers = {
        "Content-type": "application/json",
      };

      //por padrao o http.post trabalha com form encodend, como estamos mandando json, precisamos transformar
      String paramsRequestJson = json.encode(params);

      //var response = await http.post(url, body: params);
      var response =
          await http.post(url, body: paramsRequestJson, headers: headers);

      print('Response : $response');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      //parse do body para MAP, quando for objeto {} , se for lista [{}], não pode fazer dessa forma
      Map paramsResponseJson = json.decode(response.body);

      //String nome  = paramsResponseJson['nome'];
      //String email  = paramsResponseJson['email'];
      // print('>>Nome :  $nome');
      //print('>>Email :  $email');

      //return Usuario(nome, email);
      //return Usuario(paramsResponseJson);


      if (response.statusCode == 200) {
        //O mais comum é fazer o parser no construtor do 'model', utilizando named constructor e lista de inicialização
        Usuario user = Usuario.fromJson(paramsResponseJson);
        //salvamos no shared preferences
        user.save();
        return ResponseApi.ok(user);
      }

      return ResponseApi.error(paramsResponseJson['error']);
      
    } catch (error, exception) {
      print('Erro ao tentar efetuar o login error >> $error , Exception >> $exception');
      return ResponseApi.error(
          'Ocorreu um erro ao tentar efetuar o login, contate o administrador ..');
    }
  }
}
