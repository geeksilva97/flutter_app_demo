import 'package:flutter/material.dart';

class EstoqueScreen extends StatefulWidget {
  _EstoqueState createState() => _EstoqueState();
}


class _EstoqueState extends State<EstoqueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Perda'),
        leading: null,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Leite Maranguape'),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor
              ),
            ),
            ListTile(
              title: Text('Sobre este app'),
              trailing: Icon(Icons.info),
            ),
            ListTile(
              title: Text('Sair'),
              trailing: Icon(Icons.clear),
            )
          ],
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: <Widget>[
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