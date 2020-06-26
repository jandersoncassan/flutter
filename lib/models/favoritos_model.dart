import 'package:carros/services/favorito_service.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class FavoritosModel extends ChangeNotifier {
  List<Carro> carros = [];

  void getCarros() async {
    carros = await FavoritoService.getCarros();

    notifyListeners();
  }
}
