import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/bloc/loripsum_bloc.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _bloc = LoripsumBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch();
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
          CachedNetworkImage(imageUrl: widget.carro.urlFoto),
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
                color: Colors.red,
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
        print('Editar');
        break;
      case 'Deletar':
        print('Deletar');
        break;
      case 'Shared':
        print('Shared');
        break;
    }
  }

  void _onClikFavorito() {}

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
