import 'package:flutter/material.dart';
import 'package:estoque_app/services/estoque_service.dart';
import 'package:badges/badges.dart';


class EstoqueScreen extends StatefulWidget {
  _EstoqueState createState() => _EstoqueState();
}


class _EstoqueState extends State<EstoqueScreen> {

  String dropdownValue;
  String codPro;
  int _numRotas = 0;

  List<String> rotas = ['01', '02', '03'];


  var service = EstoqueService();



  Widget _buildForm(BuildContext context){

    service.listaRotas().then((dynamic data) {
      
    });

    var orientation = Orientation.landscape == MediaQuery.of(context).orientation;

    return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: <Widget>[


            DropdownButton<String>(
              isExpanded: true,
              hint: Text('Selecione uma rota'),
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue; 
                });
                // dropdownValue = newValue;
                print(newValue);
              },
              items: rotas
                .map<DropdownMenuItem<String>>((String value) {
                  var dropdownMenuItem = DropdownMenuItem<String>(
                    value: value,
                    child: Text('Rota $value'),
                  );
                  return dropdownMenuItem;
                }).toList(),
            ),


            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    hint: Text('Produto'),
                    value: codPro,
                    onChanged: (String value) {
                      setState(() {
                       this.codPro = value; 
                      });
                    },
                    items: <String>['010.01', '015.01', '015.02'].map<DropdownMenuItem<String>>((String value) {
                      var dropdownMenuItem = DropdownMenuItem<String>(
                        value: value,
                        child: Text(value)
                      );
                      return dropdownMenuItem;
                    },
                    ).toList()
                  )
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Quantidade'
                    ),
                  ),
                ),


                SizedBox(
                  width: 10.0,
                ),

                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Transação'
                    ),
                  ),
                )
              ],
            ),


            Divider(),
            SizedBox(height: 10,),

            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text('PRONTO'),
                    color: Colors.tealAccent,
                    onPressed: () {

                    },
                  ),
                ),
              ],
            )
          ],
        );
  }


  Widget _buildDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/logo.png', scale: 1.5,),
                  SizedBox(height: 10.0,),
                  Text(
                    'Leite Marangupe',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor
              ),
            ),

            ListTile(
              title: Text('Home'),
              trailing: Icon(Icons.home),
              onTap: () {
                print('Homepage');
              },
            ),

            ListTile(
              title: Text('Sobre este app'),
              trailing: Icon(Icons.info),
              onTap: (){
                print('sobre este app');
              },
            ),
            ListTile(
              title: Text('Sair'),
              trailing: Icon(Icons.clear),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    var service = EstoqueService();
    service.listaRotas();


    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo Estoque'),
        leading: null,
        actions: <Widget>[
          BadgeIconButton(
            itemCount: _numRotas,
            icon: Icon(Icons.remove_red_eye, color: Colors.white,),
            badgeColor: Colors.red,
            badgeTextColor: Colors.white,
            hideZeroCount: true,
          )
        ],
      ),

      drawer: _buildDrawer(context),

      body: SafeArea(
        child: _buildForm(context)
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Nova rota',
        onPressed: (){
          setState(() {
           _numRotas++; 
          });
        },
      ),
    );
  }
}