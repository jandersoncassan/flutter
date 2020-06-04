import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String textButton;
  Function onPressed;
  bool showProgress;

  AppButton(this.textButton, {this.onPressed, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      // envolvemos o raisedbutton em container por causa do heigth
      height: 46,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.blue,
        //TRATAMENTO PARA EXIBICAO DA ANIMACAO DE PROGRESS
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              )
            : Text(
                textButton,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
      ),
    );
    
  }
}
