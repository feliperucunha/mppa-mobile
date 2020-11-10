import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/interface1.dart';
import 'interface1.dart';
import 'package:custom_switch/custom_switch.dart';

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
        body: ListView(
          key: _formKey,
          padding: const EdgeInsets.all(5),
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              margin: EdgeInsets.only(left: 150.0, right: 150.0),
              child: Image.asset(
                'images/GEDOC.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              padding: EdgeInsets.only(bottom: 85.0),
              child: MyStatefulWidget(),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(width: 2.0, color: Colors.grey),
              )),
              padding: EdgeInsets.only(top: 20.0),
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: HomeScreen(),
            ),
          ],
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
          color: Color(0xFF1A237E),
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
                    MaterialPageRoute(builder: (context) => Interface1()),
                  );
                },
                child: new Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Document> documents;
  List<Document> selectedDocuments;

  @override
  void initState() {
    selectedDocuments = [];
    documents = Document.getDocuments();
    super.initState();
  }

  onSelectedRow(bool selected, Document document) async {
    setState(() {
      if (selected) {
        final snackBar = SnackBar(
          margin:
              EdgeInsets.only(left: 0.0, right: 0.0, top: 5.0, bottom: 104.0),
          backgroundColor: Color(0xFF1A237E),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text(
            'Notificação ativada para ${document.protocolo}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        selectedDocuments.add(document);
      } else {
        final snackBar = SnackBar(
          margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 104.0),
          backgroundColor: Color(0xFF1A237E),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text(
            'Notificação desativada para ${document.protocolo}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        selectedDocuments.remove(document);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('Protocolo',
                style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
            numeric: true,
          ),
          DataColumn(
            label: Text('Assunto',
                style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
            numeric: false,
          ),
          DataColumn(
            label: Text('    Fase',
                style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
            numeric: false,
          ),
        ],
        rows: documents
            .map(
              (document) => DataRow(
                  selected: selectedDocuments.contains(document),
                  onSelectChanged: (b) {
                    onSelectedRow(b, document);
                  },
                  cells: [
                    DataCell(Container(
                        width: 63,
                        height: 5,
                        margin: const EdgeInsets.only(
                            right: 0, left: 0, top: 2, bottom: 2),
                        padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: Text(document.protocolo,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center))),
                    DataCell(Container(
                        width: 60,
                        margin: const EdgeInsets.only(
                            right: 0, left: 0, top: 2, bottom: 2),
                        padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: Text(document.assunto,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center))),
                    DataCell(Container(
                        width: 75,
                        margin: const EdgeInsets.only(
                            right: 0, left: 0, top: 2, bottom: 2),
                        padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                        //color: Colors.blue,
                        child: Text(document.fase,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center))),
                  ]),
            )
            .toList(),
      ),
    );
  }
}

class Document {
  String protocolo;
  String assunto;
  String fase;

  Document({this.protocolo, this.assunto, this.fase});

  static List<Document> getDocuments() {
    return <Document>[
      Document(protocolo: "2131/2020", assunto: "Remoto", fase: "Devolvido"),
      Document(protocolo: "5874/2020", assunto: "Médico", fase: "Encaminhado"),
      Document(protocolo: "6895/2020", assunto: "Ponto", fase: "Arquivado"),
      Document(
          protocolo: "4789/2020", assunto: "Frequência", fase: "Arquivado"),
      Document(protocolo: "2548/2020", assunto: "Remoto", fase: "Encaminhado"),
      Document(protocolo: "*********", assunto: "*******", fase: "**********"),
      Document(protocolo: "*********", assunto: "*******", fase: "**********"),
    ];
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'Notificações para todos',
            style: TextStyle(
                color: Color(0xFF1A237E),
                fontSize: 21.0,
                fontWeight: FontWeight.bold),
          ),
          CustomSwitch(
            activeColor: Colors.blue,
            value: status,
            onChanged: (value) {
              print("VALUE : $value");
              setState(() {
                status = value;
              });
            },
          ),
        ]);
  }
}
