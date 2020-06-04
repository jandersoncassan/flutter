import 'package:carros/models/entity.dart';

import 'carro.dart';

class Favorito extends Entity {
  int id;
  String nome;

   Favorito.fromCarro(Carro carro){
    this.id = carro.id;
    this.nome = carro.nome;
  }

  Favorito.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}
