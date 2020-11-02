import 'package:flutter/material.dart';
import 'package:hello_world/interface1.dart';
import 'interface1.dart';

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
            PaginatedDataTable(
              header: Text('Documentos em Processamento'),
              rowsPerPage: 4,
              columns: [
                DataColumn(label: Text('Header A')),
                DataColumn(label: Text('Header B')),
                DataColumn(label: Text('Header C')),
              ],
              source: _DataSource(context),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: SwitchWidget(),
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

class _Row {
  _Row(
    this.valueA,
    this.valueB,
    this.valueC,
  );

  final String valueA;
  final String valueB;
  final String valueC;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('Cell A1', 'CellB1', 'CellC1'),
      _Row('Cell A2', 'CellB2', 'CellC2'),
      _Row('Cell A3', 'CellB3', 'CellC3'),
      _Row('Cell A4', 'CellB4', 'CellC4'),
    ];
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class SwitchWidget extends StatefulWidget {
  @override
  SwitchWidgetClass createState() => new SwitchWidgetClass();
}

class SwitchWidgetClass extends State {
  bool switchControl = false;
  var textHolder = 'Notificação para todos';

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Notificação para todos';
      });
      print('Notificação para todos');
    } else {
      setState(() {
        switchControl = false;
        textHolder = 'Notificação para todos';
      });
      print('Notificação para todos');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '$textHolder',
            style: TextStyle(fontSize: 24),
          ),
          Transform.scale(
              scale: 1.5,
              child: Switch(
                onChanged: toggleSwitch,
                value: switchControl,
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              )),
        ]);
  }
}
