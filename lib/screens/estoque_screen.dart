import 'package:flutter/material.dart';
import 'package:estoque_app/services/estoque_service.dart';


class EstoqueScreen extends StatefulWidget {
  _EstoqueState createState() => _EstoqueState();
}


class _EstoqueState extends State<EstoqueScreen> {

  String dropdownValue = null;


  Widget _buildForm(BuildContext context){
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
              items: <String>['01', '02']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('Rota ${value}'),
                  );
                }).toList(),
            ),

            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Field 1',
              ),
            ),


         

            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Field 2',
              ),
            ),

            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Field 3',
              ),
            ),

            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Field 4',
              ),
            ),
          ],
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
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/logo.png', scale: 1.5,)
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
                print('saindo...');
              },
            )
          ],
        ),
      ),

      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(decoration: BoxDecoration(color: Colors.indigo), height: 80.0, width: 80.0,),
                Container(decoration: BoxDecoration(color: Colors.teal), height: 80.0, width: 80.0,),
                Container(decoration: BoxDecoration(color: Colors.pink), height: 80.0, width: 80.0,),
              ]
            ),

            
            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Field 2',    
              ),
            ),
          ],
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        tooltip: 'Sair',
        onPressed: (){
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
          Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
        },
      ),
    );
  }
}