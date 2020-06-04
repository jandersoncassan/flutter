import 'package:carros/models/favorito.dart';

import 'base_dao.dart';

class FavoritosDAO extends BaseDAO <Favorito>{
  
  @override
  String get tableName => 'favorito';

  @override
  Favorito fromJson(Map<String, dynamic> map) {
    return Favorito.fromJson(map); 
  }

 }
