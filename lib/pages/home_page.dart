import 'package:carros/pages/carro_form_page.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/favoritos_page.dart';
import 'package:carros/widgets/carros_page.dart';
import 'package:carros/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

//**
// * PARA NAO FAZER REQUISICAO TODA HORA 'TABS' PRECISAMOS DO STATEFULL E with SingleTickerProviderStateMixin TIPANDO COM A CLASSE
// */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    //buscamos o indice da ultima TAB, e depois usamos a função .then ..
    //passando como paramentro o tipo que já sabemos, nesse caso int e setamos o valor novamente
    // Future<int> indexFuture = Prefs.getInt('tabIdx');
    // indexFuture.then((int index) {
    //   this._tabController.index = index;
    // });

    // this._tabController.addListener(() {
    //   //salvamos o indice da ultima TAB que o usuario acessou
    //   Prefs.setInt('tabIdx', this._tabController.index);
    // });

    //Uma outra forma de buscar o valor sem precisar utilizar a function then() fo Future, é efetuar a busca utilizando o async / await,
    //mas nesse caso precisamos criar um metodo separado, pq não podemos utilizar async/await dentro do mtodo initState()!!
    _initTabs();

    //Escutando uma stream
  }

  _initTabs() async {
    _tabController = TabController(length: 4, vsync: this);
    //var index = await Prefs.getInt('tabIdx');
    // this._tabController.index = index;

    // this._tabController.addListener(() {
    //   //salvamos o indice da ultima TAB que o usuario acessou
    //   Prefs.setInt('tabIdx', this._tabController.index);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Classicos',
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: 'Esportivos',
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: 'Luxo',
              icon: Icon(Icons.directions_car),
            ),
            Tab(
              text: 'Favoritos',
              icon: Icon(Icons.favorite),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosPage('classicos'),
          CarrosPage('esportivos'),
          CarrosPage('luxo'),
          FavoritosPage(),
        ],
      ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAdicionarCarro,
      ),
    );
  }

  void _onClickAdicionarCarro() {
    push(context, CarroFormPage());
  }
}
