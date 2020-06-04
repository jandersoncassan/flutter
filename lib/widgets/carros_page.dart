import 'package:carros/bloc/carros_bloc.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/services/carro_api.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/carros_listview.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

//* PARA GUARDAR O ESTADO DAS TABS E NAO IR TODA CLICK NO WEBSERVICE, PRECISAMOS DE STATEFULL E UTILIZAR with AutomaticKeepAliveClientMixin tipando com a classe
//@override
// bool get wantKeepAlive => true;
//super.build(context);
class CarrosPage extends StatefulWidget {
  String tipo;
  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  final _bloc = CarrosBloc();
  String get tipo => widget.tipo;

  //List<Carro> carros;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //FORMA 01
    // Future<List<Carro>> futureCarros = CarroApi.getCarros(widget.tipo);
    // futureCarros.then((carros) {
    //   setState(() {
    //     this.carros = carros;
    //   });
    // });
    // if (this.carros == null) {
    //   Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    //FORMA 02
    //_loadData();

    //FORMA 03
    //_loadData();

    //UTILIZANDO O PADRAO BLOC
    _fetch(tipo);
  }

  _fetch(tipo) {
    _bloc.fetch(tipo);
  }

  // void _loadData() async {
  //   List<Carro> carros = await CarroApi.getCarros(widget.tipo);
  //   setState(() {
  //     this.carros = carros;
  //   });
  // }

  // void _loadData() async {
  //   List<Carro> carros = await CarroApi.getCarros(widget.tipo);
  //   setState(() {
  //     _streamController.add(carros);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //Future<List<Carro>> futureCarros = CarroApi.getCarros(widget.tipo);
    //TODA VEZ QUE PRECISAMOS DE DADOS DE UM FUTURE PARA CARREGAR WIDGET, PRECISAMOS DO FUTURE BUILDER

    //FOMAR 01 E 02
    // return _listView(carros);

    //FORMA03
    //return FutureBuilder(
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error : ${snapshot.error}');
            return TextError(
              message:
                  'Ocorreu um erro ao carregar as fotos \n\n Tentar novamente',
              onpressed: _fetch(tipo),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Carro> carros = snapshot.data;
          return RefreshIndicator( //UTILIZADO PARA DAR UM REFRESH NA TELA
            onRefresh: _onRefresh,
            child: CarrosListView(carros),
          );
        });
  }

Future<void> _onRefresh() {
  // return Future.delayed(Duration(seconds: 3), ()=>{ TESTE
  //   print('doido')
  // });
  return _bloc.fetch(tipo);
}


  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    print('>>>>>> DISPOSE !!! ');
  }

  
}
