import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

//* PARA GUARDAR O ESTADO DAS TABS E NAO IR TODA CLICK NO WEBSERVICE, PRECISAMOS DE STATEFULL E UTILIZAR with AutomaticKeepAliveClientMixin tipando com a classe
//@override
// bool get wantKeepAlive => true;
//super.build(context);
class CarrosListView extends StatelessWidget {
  List<Carro> carros;
  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null
            ? carros.length
            : 0, //para nao dar erro por causa do Future
        itemBuilder: (context, index) {
          Carro c = carros[index];
          //Usamos o Column em um CARD para dar o efeito de CARD
          return Container(
            height: 280,
            child: InkWell(
              onTap: () => _onClickDetails(context, c),
              onLongPress: () => _onLongClickDetails(context, c),
              child: Card(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: c.urlFoto ??
                              "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Ferrari_FF.png",
                          width: 180,
                          height: 120,
                        ),
                      ),
                      Text(
                        c.nome ?? 'Cadillac Eldorado',
                        maxLines: 1,
                        overflow: TextOverflow
                            .ellipsis, // se passar cria os 3 pontinhos ...
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'descrição ..',
                        style: TextStyle(fontSize: 16),
                      ),
                      ButtonBarTheme(
                        data: ButtonBarThemeData(),
                        child: ButtonBar(
                          //default no CARD
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Detalhes'),
                              onPressed: () => _onClickDetails(context, c),
                            ),
                            FlatButton(
                              child: const Text('Share'),
                              onPressed: () => _onClickShare(context, c),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

          //Iremos utilizar o conceito de CARD , por isso utilizaremos Colluns
          // return Row(
          //   children: <Widget>[
          //     Image.network(
          //       c.urlFoto,
          //       width: 150,
          //     ),
          //     Flexible( //colocamos o text aqui para ajustar o layout .. tanto na quebra quanto ellipse
          //       child: Text(
          //         c.nome,
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis, // se passar cria os 3 pontinhos ...
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     ),
          //   ],
          // );

          //!!Nao vamos usar o ListTile, pq ele colocaalguns espaçamentos, nesse caso não queremos!
          // return ListTile(
          //   leading: Image.network(c.urlFoto),
          //   title: Text(
          //     c.nome,
          //     style: TextStyle(fontSize: 22),
          //   ),
          // );
        },
      ),
    );
  }

  _onClickDetails(context, Carro carro) {
    push(context, CarroPage(carro));
  }

  _onLongClickDetails2(BuildContext context, Carro c) { //showDialog
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(c.nome),
            children: <Widget>[
              ListTile(
                title: Text('Detalhes'),
                leading: Icon(Icons.directions_car),
                onTap: () {
                  pop(context);
                  _onClickDetails(context, c);
                },
              ),
              ListTile(
                title: Text('Share'),
                leading: Icon(Icons.share),
                onTap: () {
                  pop(context);
                  _onClickShare(context, c);
                },
              )
            ],
          );
        });
  }

  _onLongClickDetails(BuildContext context, Carro c) { //showModalBottomSheet
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  c.nome,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text('Detalhes'),
                leading: Icon(Icons.directions_car),
                onTap: () {
                  pop(context);
                  _onClickDetails(context, c);
                },
              ),
              ListTile(
                title: Text('Share'),
                leading: Icon(Icons.share),
                onTap: () {
                  pop(context);
                  _onClickShare(context, c);
                },
              )
            ],
          );
        });
  }

  void _onClickShare(BuildContext context, Carro c) {
    print('clique shared! ${c.nome}');
    Share.share(c.urlFoto);
  }
}
