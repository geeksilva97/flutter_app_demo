import 'package:flutter/material.dart';
import 'package:estoque_app/services/estoque_service.dart';


class EstoqueScreen extends StatefulWidget {
  _EstoqueState createState() => _EstoqueState();
}


class _EstoqueState extends State<EstoqueScreen> {

  String dropdownValue;
  String codPro;


  // model for form
  ItemRota rota = ItemRota();

  // model
  Produto produto = Produto();

  List<ItemRota> itemRotas = [
    ItemRota(rota: '01', produtos: <Produto>[
      Produto(codPro: '010.01', qtd: 10, codTns: '1234ABC'),
      Produto(codPro: '010.01', qtd: 5, codTns: '168'),
      Produto(codPro: '010.01', qtd: 2, codTns: '855'),
      Produto(codPro: '015.01', qtd: 10, codTns: '999'),
    ].toList())
  ];

  List<DropdownMenuItem<String>> menuProdutos = <String>[
    '010.01',
    '015.01',
    '015.02',
    '020.01',
    '020.02'
  ]
          .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
          .toList();


  List<DropdownMenuItem<String>> menuRotas = [
    DropdownMenuItem<String>(
      value: '01',
      child: Text('ROTA 01')
    )
  ];



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
    return Scaffold(
      appBar: AppBar(
        title: Text('Estoque', style: TextStyle(color: Colors.white),),
        leading: null,
        actions: <Widget>[
         IconButton(
           icon: Icon(Icons.remove_red_eye, color: Colors.white,),
           color: Colors.white,
           onPressed: () {},
         )
        ],
      ),

     
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
                padding: EdgeInsets.only(top: 8.0, bottom: 20.0, left: 12.0, right: 12.0),//EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: const Color(0xDDFFE0CC),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      items: menuRotas,
                      value: rota.rota,
                      onChanged: (String newValue){
                        setState(() {
                          rota.rota = newValue; 
                        });
                      },
                      hint: Text('SELECIONE A ROTA', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                            initialValue: rota.qtdLeiteC != null ? rota.qtdLeiteC.toString() : '',
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'QTD. LEITE C',  
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0,),

                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'QTD. CAIXAS LEVADAS'
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0,),

                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue: '',
                            keyboardType: TextInputType.number,
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
                              items: menuProdutos,
                              hint: Text('PRODUTO'),
                              onChanged: (String value) {
                                print('PRODUTO $value');
                              },
                            ),
                          ),


                          SizedBox(width: 5,),

                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              onFieldSubmitted: (String value) {
                                produto.qtd = value as int;
                              },
                              decoration: InputDecoration(
                                labelText: "QUANTIDADE",
                              ),
                            ),
                          ),


                          SizedBox(width: 5,),

                          Expanded(
                            flex: 5,
                              child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
                              ),
                              items: menuItems,
                              value: produto.codTns,
                              hint: Text('TRANSAÇÃO'),
                              onChanged: (String value) {
                                produto.codTns = value;
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
                            onPressed: (){
                              rota.produtos.add(produto);
                              produto = Produto();
                            },
                          )
                        ],
                      ),
                    ),


                    SizedBox(height: 12,),

                    Table(
                      border: TableBorder(
                        bottom: BorderSide(
                          width: 1.0,
                          color: Colors.deepOrangeAccent
                        )
                      ),
                      children: [
                        TableRow(  
                          children: [
                            TableCell(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('PRODUTO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                            ), verticalAlignment: TableCellVerticalAlignment.middle,),

                             TableCell(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('QUANTIDADE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                            ), verticalAlignment: TableCellVerticalAlignment.middle,),

                             TableCell(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('TRANSAÇÃO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                            ), verticalAlignment: TableCellVerticalAlignment.middle,)
                          ]
                        ),



                        
                      ],
                    ),

                    SizedBox(height: 12,),


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