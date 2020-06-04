import 'package:carros/bloc/login_bloc.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/services/response_api.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _focusPassword = FocusNode();

 // StreamController _streamController = StreamController<bool>();
 final _bloc = LoginBloc();

  // @override
  // void initState() {
  //   super.initState();

  //   //MUDAMOS ESSA LOGICA PARA O SplashPage
  //   // Future<Usuario> userFuture = Usuario.get();
  //   // userFuture.then((Usuario user) {
  //   //   if (user != null) {
  //   //     //usamos o setState para redesenhar a tela
  //   //     setState(() {
  //   //       this._tEmail.text = user.login;
  //   //       //ou podiamos iniciar o login automatico;
  //   //       push(context, HomePage(), replace: true);
  //   //     });
  //   //   }
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        //envolvemos o listview em container por causa do padding
        padding: EdgeInsets.all(16),
        child: ListView(
          //garante a rolagem da tela
          children: <Widget>[
            AppText(
              'Email', 'Digite seu email',
              controller: _tEmail,
              validator:
                  _validateLogin, // por ser function get nao precisamos passar o parametro
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusPassword,
            ),
            _sizeBox(10),
            AppText('Senha', 'Digite sua senha',
                controller: _tPassword,
                isPassword: true,
                validator: _validatePassword,
                keyboardType: TextInputType.number,
                focusNode: _focusPassword),
            _sizeBox(20),
            // AppButton(
            //   'Login',
            //   onPressed: _onClickLogin,
            //   showProgress: _showProgress,
            // )
            StreamBuilder<bool>(
              stream: _bloc.stream,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                return AppButton(
                   'Login',
                    onPressed: _onClickLogin,
                    showProgress: snapshot.data ?? false
                );
              },
            )
          ],
        ),
      ),
    );
  }

  SizedBox _sizeBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  _onClickLogin() async {
    //validate() busca todos os validators no  TextFormField
    if (!_formKey.currentState.validate()) return;

    String email = _tEmail.text;
    String password = _tPassword.text;

    print('Email : $email - Password : $password');

    //setShowProgress(true);
   // _streamController.add(true);

     ResponseApi<Usuario> response = await _bloc.fetch(email, password);

   // ApiResponse<Usuario> response = await LoginApi.login(email, password);
    if (response.isValid) {
      //  print('>>> ${response.result}');

      push(context, HomePage());
    } else {
      alert(context, response.message, callback: () => print('teste'));
      // print('${response.message}');
    }
    //setShowProgress(false);
    // _streamController.add(false);
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return 'Favor informar o email';
    }
    return null;
  }

  String _validatePassword(String text) {
    if (text.isEmpty) {
      return 'Favor informar a senha';
    }
    if (text.length < 3) {
      return 'A senha precisa conter no minimo 6 caracteres';
    }
    return null;
  }

  // void setShowProgress(bool isShowProgress) {
  //   setState(() {
  //     this._showProgress = isShowProgress;
  //   });
  // }
  
  //AO USAR STREAM PRECISAMOS FECHAR NO METODO DISPOSE
  @override
  void dispose(){
    super.dispose();
    _bloc.dispose();
  }
}
