import 'package:flutter/material.dart';
import 'package:estoque_app/services/estoque_service.dart';
import 'package:badges/badges.dart';


class EstoqueScreen extends StatefulWidget {
  _EstoqueState createState() => _EstoqueState();
}


class _EstoqueState extends State<EstoqueScreen> {

  String dropdownValue;
  String codPro;

  List<ItemRota> itemRotas = [
    ItemRota(rota: '01', produtos: <Produto>[
      Produto(codPro: '010.01', qtd: 10, codTns: '1234ABC'),
      Produto(codPro: '010.01', qtd: 5, codTns: '168'),
      Produto(codPro: '010.01', qtd: 2, codTns: '855'),
      Produto(codPro: '015.01', qtd: 10, codTns: '999'),
    ].toList())
  ];

  List<DropdownMenuItem<String>> menuRotas = [
    DropdownMenuItem<String>(
      value: '01',
      child: Padding(child: Text('ROTA 01'), padding: EdgeInsets.symmetric(vertical: 18.0),)
    ),

    DropdownMenuItem<String>(
      value: '02',
      child: Padding(child: Text('ROTA 02'), padding: EdgeInsets.symmetric(vertical: 18.0),)
    )
  ];
 




  List<String> rotas = ['01', '02', '03'];
  var service = EstoqueService();


  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem<String>(
      value: 'item 01',
      child: Padding(child: Text('item 01'), padding: EdgeInsets.symmetric(vertical: 18.0),)
    )
  ];

  List<DropdownMenuItem<String>> menuTns = [
     DropdownMenuItem<String>(
      value: 'item 01',
      child: Padding(child: Text('item 01'), padding: EdgeInsets.symmetric(vertical: 18.0),)
    )
  ];

  var _produtos = <String>['010.01', '015.01', '015.02'].map<DropdownMenuItem<String>>((String value) {
      var dropdownMenuItem = DropdownMenuItem<String>(
        value: value,
        child: Text(value)
      );
      return dropdownMenuItem;
    },
  ).toList();


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



  Widget _buildCard(ItemRota itemRota) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0),
              child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Rota ${itemRota.rota}', style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 6.0,)

          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estoque'),
        leading: null,
        actions: <Widget>[
         IconButton(
           icon: Icon(Icons.remove_red_eye, color: Colors.white,),
           color: Colors.white,
           onPressed: () {},
         )
        ],
      ),

      // drawer: _buildDrawer(context),

     
     body: SafeArea(
       child: ListView(
         children: <Widget>[
           Padding(child: _buildForm(context), padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),)
         ],
       ),
     ),
    );
  }





  
  Widget _buildForm(BuildContext context){
    return Card(
      elevation: 15.0,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFC4D0FF),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      items: menuRotas,
                      onChanged: (String newValue){},
                      hint: Text('SELECIONE A ROTA', style: TextStyle(fontWeight: FontWeight.bold),),
                      decoration: InputDecoration( 
                       
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'QTD. LEITE C',  
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0,),

                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'QTD. CAIXAS LEVADAS'
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0,),

                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'QTD. CAIXAS RETORNADAS'
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),

              ),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: Column(
                  children: <Widget>[
                    Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                              child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 17.9, horizontal: 8.0),
                              ),
                              items: menuItems,
                              hint: Text('PRODUTO'),
                              onChanged: (String value) {
                                print(value);
                              },
                            ),
                          ),


                          SizedBox(width: 5,),

                          Expanded(
                            flex: 2,
                            child: TextFormField(decoration: InputDecoration(
                              labelText: "QUANTIDADE",
                            ),),
                          ),


                          SizedBox(width: 5,),

                          Expanded(
                            flex: 5,
                              child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
                              ),
                              items: menuItems,
                              hint: Text('TRANSAÇÃO'),
                              onChanged: (String value) {
                                print(value);
                              },
                            ),
                          )
                        ],
                      ),

                     ButtonTheme.bar(
                        child: ButtonBar(
                        children: <Widget>[
                          RaisedButton.icon(
                            splashColor: Theme.of(context).splashColor,
                            icon: Icon(Icons.add, color: Colors.white,),
                            label:  Text('Adicionar produto', style: TextStyle(color: Colors.white),),
                            onPressed: (){},
                          )
                        ],
                      ),
                    ),



                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text('PRONTO'),
                            onPressed: () {

                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
    );
  }
}


class Produto {
  String codPro;
  int qtd;
  String codTns;

  Produto({
    String codPro,
    int qtd,
    String codTns
  }) :
    this.codPro = codPro,
    this.qtd = qtd,
    this.codTns = codTns;
}

class ItemRota {
  String rota;
  int qtdLeiteC;
  int qtdCaixas;
  int qtdCaixaRetorno;
  List<Produto> produtos;

  ItemRota({String rota, List<Produto> produtos, int qtdLeiteC, int qtdCaixas, int qtdCaixaRetorno}) :
    this.rota = rota,
    this.produtos = produtos,
    this.qtdLeiteC = qtdLeiteC,
    this.qtdCaixas = qtdCaixas,
    this.qtdCaixaRetorno = qtdCaixaRetorno;
}