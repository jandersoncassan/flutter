import 'package:carros/models/usuario.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future user = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: user,
              builder: (context, snapshot) {
                Usuario user = snapshot.data;
                return user != null
                    ? _userAccountDataHeader(user)
                    : Container();
              },
            ),
            ListTile(
              leading: Icon(Icons.star), //propriedade da esquerda
              title: Text('Favoritos'),
              subtitle: Text('Mais Informações ..'),
              trailing: Icon(Icons.arrow_forward), //propriedade da direita
              onTap: () {
                print('Favoritos');
                Navigator.pop(
                    context); // como é feito um push para abrir, ao clicar precisamos fazr o pop para fechar
              },
            ),
            ListTile(
              leading: Icon(Icons.help), //propriedade da esquerda
              title: Text('Ajuda'),
              subtitle: Text('Mais Informações ..'),
              trailing: Icon(Icons.arrow_forward), //propriedade da direita
              onTap: () {
                print('Ajuda');
                Navigator.pop(
                    context); // como é feito um push para abrir, ao clicar precisamos fazr o pop para fechar
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app), //propriedade da esquerda
              title: Text('Logout'),
              trailing: Icon(Icons.arrow_forward), //propriedade da direita
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _userAccountDataHeader(Usuario user) {
    print('>>>> $user');
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        //backgroundImage: AssetImage("assets/images/dog1.png")
        backgroundImage: NetworkImage(
          // "https://d1vq0ypifqihlw.cloudfront.net/assets/img/myphoto.jpg",
          user.urlFoto,
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    pop(context);
    push(context, LoginPage(), replace: true);
  }
}
