import 'package:carros/bloc/favoritos_bloc.dart';
import 'package:carros/main.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/widgets/carros_listview.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carros/models/favoritos_model.dart';

//* PARA GUARDAR O ESTADO DAS TABS E NAO IR TODA CLICK NO WEBSERVICE, PRECISAMOS DE STATEFULL E UTILIZAR with AutomaticKeepAliveClientMixin tipando com a classe
//@override
// bool get wantKeepAlive => true;
//super.build(context);
class FavoritosPage extends StatefulWidget {
  FavoritosPage();

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
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
    _fetch();
  }

  _fetch() {
    // FavoritosBloc favoritosBloc = Provider.of<FavoritosBloc>(context, listen: false); //qdo não precisamos ficar escutando o model
    // favoritosBloc.fetch();

    FavoritosModel favoritosModel = Provider.of<FavoritosModel>(context,
        listen: false); //recuperando o objeto
    favoritosModel.getCarros();
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
    //FavoritosBloc favoritosBloc = Provider.of<FavoritosBloc>(context);
    FavoritosModel favoritosModel = Provider.of<FavoritosModel>(
        context); //sem listen : false, pq ele precisa ficar ouvindo
    List<Carro> carros = favoritosModel.carros;

    if (carros.isEmpty) {
      return Center(
        child: Text(
          'Nenhum carro no favoritos!',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return RefreshIndicator(
      //UTILIZADO PARA DAR UM REFRESH NA TELA
      onRefresh: _onRefresh,
      child: CarrosListView(carros),
    );

    // return StreamBuilder(  //COM STREAMBUIDER
    //     stream: favoritosBloc.stream,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         print('Error : ${snapshot.error}');
    //         return TextError(
    //           message:
    //               'Ocorreu um erro ao carregar as fotos \n\n Tentar novamente',
    //           onpressed: _fetch(),
    //         );
    //       }
    //       if (!snapshot.hasData) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       List<Carro> carros = snapshot.data;
    //       return RefreshIndicator(
    //         //UTILIZADO PARA DAR UM REFRESH NA TELA
    //         onRefresh: _onRefresh,
    //         child: CarrosListView(carros),
    //       );
    //     });
  }

  Future<void> _onRefresh() {
    // return Future.delayed(Duration(seconds: 3), ()=>{ TESTE
    //   print('doido')
    // });
   // return Provider.of<FavoritosBloc>(context).fetch();
      //FavoritosBloc favoritosBloc = Provider.of<FavoritosBloc>(context);
    Provider.of<FavoritosModel>(context, listen: false).getCarros();
  }
}
