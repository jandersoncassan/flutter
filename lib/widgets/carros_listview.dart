import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

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
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CachedNetworkImage(
                      imageUrl:
                      c.urlFoto ??
                          "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Eldorado.png",
                      width: 250,
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
                  ButtonBar(
                    //default no CARD
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Detalhes'),
                        onPressed: () => onClickDetails(context, c),
                      ),
                      FlatButton(
                        child: const Text('Share'),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ],
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

  onClickDetails(context, Carro carro) {
    push(context, CarroPage(carro));
  }
}
