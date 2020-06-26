import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/bloc/loripsum_bloc.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro_form_page.dart';
import 'package:carros/services/carro_api.dart';
import 'package:carros/services/favorito_service.dart';
import 'package:carros/services/response_api.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:carros/utils/event_bus.dart';


class CarroEvent extends Event{
  // salvar, excluir, editar ...
  String acao;
  //esportivos, classicos, luxo ...
  String tipo;

  CarroEvent(this.acao, this.tipo);
}

class CarroPage extends StatefulWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _bloc = LoripsumBloc();

  Color color = Colors.grey;

  Carro get carro => widget.carro;

  @override
  void initState() {
    //metodo utilizado para inicializacao do nosso widget
    super.initState();
    _bloc.fetch();

    FavoritoService.isFavorito(carro).then((favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopupMenu(value),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'Editar', child: Text('Editar')),
                PopupMenuItem(value: 'Deletar', child: Text('Deletar')),
                PopupMenuItem(value: 'Shared', child: Text('Shared')),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.carro.urlFoto ??
                "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Ferrari_FF.png",
          ),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text(widget.carro.nome, fontSize: 20, bold: true),
              text(widget.carro.tipo)
            ],
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 30,
              ),
              onPressed: _onClikFavorito,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 30,
              ),
              onPressed: _onClikFavorito,
            ),
          ],
        )
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text(widget.carro.descricao, fontSize: 14, bold: true),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
            stream: _bloc.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return text(snapshot.data);
            }),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case 'Editar':
        push(
          context,
          CarroFormPage(
            carro: carro,
          ),
        );
        break;
      case 'Deletar':
        deletar();
        break;
      case 'Shared':
        print('Shared');
        break;
    }
  }

  void _onClikFavorito() async {
    print('Favorito ${carro.id}');
    bool favorito = await FavoritoService.favoritarCarros(context, carro);
    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  void deletar() async{
      ResponseApi<Map> response = await CarroApi.delete(carro);

    //await Future.delayed(Duration(seconds: 3));

    if(response.isValid){
      alert(context, response.result["msg"], callback: (){
         EventBus.get(context).sendEvents(CarroEvent('deletar', carro.tipo));
        pop(context);
      });
    }else{
      alert(context, response.message);
    }

  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
