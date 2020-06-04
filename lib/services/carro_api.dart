import 'dart:convert';

import 'package:carros/models/carro.dart';
import 'package:carros/models/usuario.dart';
import 'package:http/http.dart' as http;

class CarroApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    
      // await Future.delayed(Duration(seconds: 2));

      // final carros = List<Carro>();

      // carros.add(Carro(nome: "Chevrolet Bel-Air 8V", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_BelAir.png"));
      // carros.add(Carro(nome: "Cadillac Eldorado", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Eldorado.png"));
      // carros.add(Carro(nome: "Camaro SS 1969", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Camaro_SS.png"));

      // return carros;
     
      //var urlV1 = 'http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';
      var urlV2 = 'http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';

      //utilizando a API v2 com token Authorization"
       //pode ter tipagem ou nao, é basicamente um json, no flutter map é um json
      Usuario user =  await Usuario.get();
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization" : "Bearer ${user.token}"
      };


      var response = await http.get(urlV2, headers: headers);

     // print('BEFORE DECODE : ${response.body}');
      List list = json.decode(response.body);
     // print('AFTER DECODE : $list');
      List<Carro> carros =list.map<Carro>((map) =>  Carro.fromJson(map)).toList();

      // final carros = List<Carro>();

      //  for (Map item in list) {
      //     Carro carro = Carro.fromJson(item);
      //      if(carro.urlFoto != null)
      //        carros.add(carro);
      // }
      return carros;
    
  }
}
