import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'interface2.dart';

class Interface1 extends StatelessWidget {
  final _tUsuario = TextEditingController();
  final _tSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: _body(context),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 45.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: _launchURLI,
              ),
              Text('Ministério Público Estado do Pará - MPPA',
                  style: TextStyle(fontSize: 18.0, color: Colors.white))
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blue,
      ),
    );
  }

  _launchURLI() async {
    const url = 'http://www.mppa.mp.br/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir a $url';
    }
  }

  String _validateUsuario(String text) {
    if (text.isEmpty) {
      return "Informe o usuário";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }

  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            imageLogin(),
            textFormFieldUsuario(),
            textFormFieldSenha(),
            containerButton(context),
            containerButtonAjuda()
          ],
        ));
  }

  Container imageLogin() {
    return Container(
      margin: EdgeInsets.only(left: 130.0, right: 130.0),
      child: Image.asset(
        'images/usuário.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Container textFormFieldUsuario() {
    return Container(
        height: 70.0,
        margin: EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
        padding: EdgeInsets.only(top: 5.0),
        child: TextFormField(
            controller: _tUsuario,
            validator: _validateUsuario,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18.0, color: Colors.black),
            decoration: InputDecoration(
                hintText: "Usuário do GEDOC",
                border: const OutlineInputBorder())));
  }

  Container textFormFieldSenha() {
    return Container(
        height: 70.0,
        margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
        padding: EdgeInsets.only(top: 5.0),
        child: TextFormField(
            controller: _tSenha,
            validator: _validateSenha,
            obscureText: true,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 18.0, color: Colors.black),
            decoration: InputDecoration(
                hintText: "Senha do GEDOC",
                border: const OutlineInputBorder())));
  }

  Container containerButton(BuildContext context) {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(top: 30.0, left: 115.0, right: 115.0),
      child: RaisedButton(
        color: Colors.blue,
        child: Text("Entrar",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        onPressed: () {
          _onClickLogin(context);
        },
      ),
    );
  }

  Container containerButtonAjuda() {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(top: 25.0, left: 80.0, right: 80.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
        color: Colors.white,
        child: Text("Preciso de Ajuda",
            style: TextStyle(color: Colors.blue, fontSize: 20.0)),
        onPressed: _launchURLII,
      ),
    );
  }

  _launchURLII() async {
    const url = 'http://www.mppa.mp.br/fale-conosco.htm';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir a $url';
    }
  }

  _onClickLogin(BuildContext context) {
    final usuario = _tUsuario.text;
    final senha = _tSenha.text;
    print("Login: $usuario , Senha: $senha ");

    if (usuario.isEmpty || senha.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Erro"),
              content: Text("Usuário e/ou Senha inválido(s)"),
              actions: <Widget>[
                FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        },
      );
    } else
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Interface2()),
      );
  }
}
