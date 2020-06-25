import 'dart:convert';
import 'dart:io';

import 'package:carros/models/carro.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/services/response_api.dart';
import 'package:carros/services/upload_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CarroApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    // await Future.delayed(Duration(seconds: 2));

    // final carros = List<Carro>();

    // carros.add(Carro(nome: "Chevrolet Bel-Air 8V", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_BelAir.png"));
    // carros.add(Carro(nome: "Cadillac Eldorado", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Eldorado.png"));
    // carros.add(Carro(nome: "Camaro SS 1969", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Camaro_SS.png"));

    // return carros;

    //var urlV1 = 'http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';
    var urlV2 =
        'http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';

    //utilizando a API v2 com token Authorization"
    //pode ter tipagem ou nao, é basicamente um json, no flutter map é um json
    Usuario user = await Usuario.get();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var response = await http.get(urlV2, headers: headers);

    // print('BEFORE DECODE : ${response.body}');
    List list = json.decode(response.body);
    // print('AFTER DECODE : $list');
    List<Carro> carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

    // final carros = List<Carro>();

    //  for (Map item in list) {
    //     Carro carro = Carro.fromJson(item);
    //      if(carro.urlFoto != null)
    //        carros.add(carro);
    // }
    return carros;
  }

  static Future<ResponseApi<bool>> save(Carro c, File file) async {
    try {

      if(file != null){
        var upload = await UploadService.upload(file);
        if(upload.isValid)
          c.urlFoto = upload.result;
      }
      Usuario user = await Usuario.get();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';

      if (c.id != null) {
        url += '/${c.id}';
      }

      print("POST > $url");

      String json = c.toJson();

      print("JSON > $json");

      var response = c.id == null
          ? await http.post(url, body: json, headers: headers)
          : await http.put(url, body: json, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map mapResponse = convert.json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Carro carro = Carro.fromJson(mapResponse);
        print("Novo carro: ${carro.id}");
        return ResponseApi.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ResponseApi.error('Não foi possivel salvar o carro');
      }

      return ResponseApi.error(mapResponse["error"]);
    } catch (e) {
      print(e);
      return ResponseApi.error('Não foi possivel salvar o carro');
    } 
  }

   static Future<ResponseApi<Map>> delete(Carro carro) async{
    try {
      Usuario user = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/${carro.id}';
      print("DELETE >>> $url");

      var response = await http.delete(url, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Map mapResponse = convert.json.decode(response.body);

      if (response.statusCode == 200) {
        return ResponseApi.ok(mapResponse);
      }
      return ResponseApi.error('Não foi possivel deletar o carro !');

    } catch (e) {
      print(e);
      return ResponseApi.error('Não foi possivel deletar o carro !');
    } 
  }
}
