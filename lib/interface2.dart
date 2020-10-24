import 'package:flutter/material.dart';
import 'main.dart';

void main() => runApp(Interface2());

class Interface2 extends StatefulWidget {
  @override
  _Interface2State createState() => _Interface2State();
}

class _Interface2State extends State<Interface2> {
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
                Icon(Icons.home, color: Colors.white),
                Text('Ministério Público Estado do Pará - MPPA',
                    style: TextStyle(fontSize: 18.0, color: Colors.white))
              ],
            ),
          ),
          shape: CircularNotchedRectangle(),
          color: Colors.blue,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
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
            imageGEDOC(),
          ],
        ));
  }

  Container imageGEDOC() {
    return Container(
      margin: EdgeInsets.only(left: 140.0, right: 140.0),
      child: Image.asset(
        'images/GEDOC.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
