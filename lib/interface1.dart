import 'package:flutter/material.dart';
import 'package:hello_world/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';
import 'interface2.dart';

class Interface1 extends StatefulWidget {
  @override
  _Interface1State createState() => _Interface1State();
}

class _Interface1State extends State<Interface1> {
  final _tUsuario = TextEditingController();
  final _tSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20.0),
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
          color: Color(0xFF1A237E),
        ),
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

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
            title: new Text('Você tem certeza?'),
            content: new Text('Você irá voltar para a tela anterior'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: new Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
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
        color: Color(0xFF1A237E),
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
        shape:
            RoundedRectangleBorder(side: BorderSide(color: Color(0xFF1A237E))),
        color: Colors.white,
        child: Text("Preciso de Ajuda",
            style: TextStyle(color: Color(0xFF1A237E), fontSize: 20.0)),
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
