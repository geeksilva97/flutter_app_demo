import 'package:flutter/material.dart';
import 'package:estoque_app/models/produto.dart';
import 'package:estoque_app/models/item_rota.dart';

import 'package:estoque_app/bloc/item_rota_bloc.dart';

class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Estoque', style: TextStyle(color: Colors.white)),
        leading: null,
      ),

      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              child: FormEstoque(),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            )
          ],
        ),
      ),
    );
  }
}

class FormEstoque extends StatefulWidget {
  _FormEstoqueState createState() => _FormEstoqueState();
}

class _FormEstoqueState extends State<FormEstoque> {

  String _rotaSelecionada = '01';
  ItemRota _modelItemRota = ItemRota(produtos: <Produto>[].toList());
  Produto _modelProduto = Produto();

  // definindo lista de rotas
  List<DropdownMenuItem<String>> _menuRotas = <String>['01','02','03','04','05','06',]
    .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

 // definindo lista de rotas
  List<DropdownMenuItem<String>> _menuTns = <String>['901235', '90879']
    .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();


    // definindo lista de produtos
  List<DropdownMenuItem<String>> _menuProdutos = <String>[
    '010.01',
    '015.01',
    '015.02',
    '020.01'
  ]
    .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();



  TextEditingController myController;


  @override
  void initState() {
    super.initState();
    myController  = TextEditingController(text: (_modelProduto.qtd != null) ? _modelProduto.toString() : '');
    myController.addListener(() {
      print('Editando texto \'${myController.text}\'');
      setState(() {
        if(myController.text.isNotEmpty){
          _modelProduto.qtd = int.parse(myController.text); 
        }
      });
    });
  }


  


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 20.0, left: 12.0, right: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xDDFFE0CC),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))
            ),


            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                DropdownButtonFormField<String>(
                  items: _menuRotas,
                  value: _modelItemRota.rota,
                  onChanged: (String value) {
                    setState(() {
                      _modelItemRota.rota = value;
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
                              items: _menuProdutos,
                              value: _modelProduto.codPro,
                              hint: Text('PRODUTO'),
                              onChanged: (String value) {
                                setState(() {
                                 _modelProduto.codPro = value; 
                                });
                              },
                            ),
                          ),


                          SizedBox(width: 5,),

                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: myController,
                              keyboardType: TextInputType.number,
                              // initialValue: (_modelProduto.qtd != null) ? _modelProduto.qtd.toString() : '',
                              
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
                              hint: Text('TRANSAÇÃO'),
                              items: _menuTns,
                              value: _modelProduto.codTns,
                              onChanged: (String value) {
                                  setState(() {
                                    _modelProduto.codTns = value;
                                  });
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
                              // adicionando mais um produto
                              itemRotaBloc.addProduto(_modelProduto);
                              _modelProduto = Produto();
                              setState(() {
                               myController.clear(); 
                              });
                            },
                          )
                        ],
                      ),
                    ),


                    SizedBox(height: 12,),

                    Divider(),

                    StreamBuilder(
                      stream: itemRotaBloc.getItemRotaStream,
                      // initialData: itemRotaBloc.getProdutos(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData) {
                          var produtos = snapshot.data.produtos as List<Produto>;
                          var children = produtos.map((Produto produto) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    color: Colors.grey[200],
                                    child: Dismissible(
                                      onDismissed: (DismissDirection direction) {
                                        print('Item removido');
                                        print(direction.index);
                                      },
                                      background: Container(color: Colors.red),
                                      key: ValueKey('${produto.codPro}${produto.qtd}${produto.codTns}'),
                                      child: ListTile(
                                        title: Text(produto.codPro),
                                        subtitle: Text('Quantidade: ${produto.qtd} | Transação: ${produto.codTns}'),
                                      ),
                                    ),
                                  )
                                ],
                              );
                          }).toList();


                     

                          return Column(
                            children: children,
                          );

                          // return Row(children: children, mainAxisAlignment: MainAxisAlignment.spaceBetween,);
                          // return Text('${produtos.length}');
                        }else {
                          return Text('NENUM PRODUTO ADICIONADO');
                        }
                      },
                    ),

                    SizedBox(height: 24,),

                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 40.0,
                            child: RaisedButton(
                              color: Color(0xFFFFD58A),
                              
                              child: Text('PRONTO'),
                              onPressed: () {

                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
        ],
      ),
    );
  }

}