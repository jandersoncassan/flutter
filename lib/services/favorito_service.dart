import 'package:carros/dao/favoritos_dao.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/models/favorito.dart';

class FavoritoService {

  static favoritarCarros(Carro carro) async {

    Favorito favorito = Favorito.fromCarro(carro);

    final dao = FavoritosDAO();

    bool exists = await dao.exists(carro.id);
    if(exists){
      print('Favorito delete id ${carro.id}');
      dao.delete(carro.id);
    }else{
       print('Favorito insert id ${carro.id}');
      dao.save(favorito);
    }
  }
}