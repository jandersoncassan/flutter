import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/dao/carros_dao.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/services/carro_api.dart';
import 'package:carros/utils/connectivity.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch(String tipo) async {

    bool isConnecttionOn = await isNetworkOn();
    if (!isConnecttionOn) {
      //Busca dados do banco de dados
      List<Carro> carros = await CarrosDAO().findAllByTipo(tipo);
      add(carros);
      return carros;
    }

    try {
      List<Carro> carros = await CarroApi.getCarros(tipo);
      saveData(carros);
      add(carros);
      return carros;
    } catch (exception) {
      addError(exception);
    }
  }

  saveData(List<Carro> carros){
    if(carros.isNotEmpty){
      final dao = CarrosDAO();
      carros.forEach((carro) => dao.save(carro));
    }
  }
}
