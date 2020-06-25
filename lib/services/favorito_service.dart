import 'package:carros/bloc/favoritos_bloc.dart';
import 'package:carros/dao/carros_dao.dart';
import 'package:carros/dao/favoritos_dao.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/models/favorito.dart';
import 'package:provider/provider.dart';

//import '../main.dart';

class FavoritoService {

  static Future<bool>favoritarCarros(context, Carro carro) async {

    Favorito favorito = Favorito.fromCarro(carro);

    final dao = FavoritosDAO();

    bool exists = await dao.exists(carro.id);
    if(exists){
      print('Favorito delete id ${carro.id}');
      dao.delete(carro.id);
     // favoritosBloc.fetch();
     Provider.of<FavoritosBloc>(context).fetch();

      return false;
    }else{
       print('Favorito insert id ${carro.id}');
      dao.save(favorito);
     // favoritosBloc.fetch();
      Provider.of<FavoritosBloc>(context).fetch();
      return true;
    }
  }
 
  static Future<List<Carro>> getCarros() async{
    List<Carro> carros = await CarrosDAO().query('select * from carro c, favorito f where c.id = f.id');
    return carros;

  }

 static Future<bool> isFavorito(Carro c) async{
     final dao = FavoritosDAO();
     final exists = dao.exists(c.id);
     return exists;
  }
}