import 'dart:convert';

import 'package:estoque_app/bloc/rota_bloc.dart';
import 'package:estoque_app/models/rota.dart';
import 'package:estoque_app/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:estoque_app/models/produto.dart';
import 'package:estoque_app/models/item_rota.dart';
import 'package:dio/dio.dart';
import 'package:estoque_app/bloc/item_rota_bloc.dart';
import 'package:estoque_app/bloc/transacao_bloc.dart';

class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Estoque', style: TextStyle(color: Colors.white)),
        leading: null,
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Adicionar Rota'),
              leading: Icon(Icons.add),
              onTap: () {

              },
            ),

            ListTile(
              title: Text('Consultar rotas'),
              leading: Icon(Icons.remove_red_eye),
              onTap: () {
                
              },
            )
          ],
        ),
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

  Produto _modelProduto = Produto();

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
  TextEditingController _dateFieldController = TextEditingController();
  TextEditingController _textEditingControllerDtEntrega = TextEditingController();
  TextEditingController _textEditingControllerTotal = TextEditingController();
  TextEditingController _textEditingControllerComissao = TextEditingController();

  DateTime initialDate = DateTime.now();


  FocusNode _dateFieldFocusNode = FocusNode();
  FocusNode _focusNodeDateFieldDtEntrega = FocusNode();


  Future<Null> _selectingDate(BuildContext context, DateTime initialDate, TextEditingController controller, FocusNode focusNode) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime(2100,12),
      locale: Locale('pt')
    );

    focusNode.unfocus();
    if(picked == null) return;

    String day = (picked.day < 10) ? '0${picked.day}' : picked.day.toString();
    String month = (picked.month < 10) ? '0${picked.month}' : picked.month.toString();
    String year = (picked.year < 10) ? '0${picked.year}' : picked.year.toString();

    controller.text = '$day/$month/$year'; 
  }

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


    _dateFieldFocusNode.addListener(() {
      if(_dateFieldFocusNode.hasFocus) {
        var content = _dateFieldController.text;
        DateTime _initialDate;
        if(content.isNotEmpty) {
          var dt = content.split('/');
          _initialDate = DateTime(int.parse(dt[2]), int.parse(dt[1]), int.parse(dt[0]));
        }else {
          _initialDate = DateTime.now();
        }

        _selectingDate(context, _initialDate, _dateFieldController, _dateFieldFocusNode);
      }
    });

    _focusNodeDateFieldDtEntrega.addListener((){
      if(_focusNodeDateFieldDtEntrega.hasFocus) {
        var content = _textEditingControllerDtEntrega.text;
        DateTime _initialDate;
        if(content.isNotEmpty) {
          var dt = content.split('/');
          _initialDate = DateTime(int.parse(dt[2]), int.parse(dt[1]), int.parse(dt[0]));
        }else {
          _initialDate = DateTime.now();
        }

        _selectingDate(context, _initialDate, _textEditingControllerDtEntrega, _focusNodeDateFieldDtEntrega);
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    _dateFieldFocusNode.unfocus();

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

                StreamBuilder(
                  stream: rotaBloc.rotaStream,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) {
                      print('SEM DADOS');
                      // lista as rotas
                      rotaBloc.listAll();
                      return LinearProgressIndicator();
                    }

                    var rotas = rotaBloc.getRotas();

                    return DropdownButtonFormField<Rota>(
                      value: rotaBloc.rotaSelecionada,
                      hint: Text('SELECIONE UMA ROTA', style: TextStyle(fontWeight: FontWeight.bold),),
                      onChanged: (Rota rota){
                        rotaBloc.select(rota);
                      },
                      items: rotas.map<DropdownMenuItem<Rota>>((Rota rota){
                        return DropdownMenuItem<Rota>(
                          value: rota,
                          child: Text('ROTA ${rota.codRoe}'),
                        );
                      }).toList(),
                    );
                  },
                ),

               

                Row(
                  mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                         Expanded(
                            flex: 2,
                            child: TextFormField(
                            focusNode: _focusNodeDateFieldDtEntrega,
                            controller: _textEditingControllerDtEntrega,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: 'DATA DE ENTREGA',  
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _textEditingControllerTotal,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'TOTAL LEITE C'
                            ),
                          ),
                        )
                      ],
                    ),


                    // botão de consulta dos movimentos
                   ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            RaisedButton.icon(
                              splashColor: Theme.of(context).splashColor,
                              color: Theme.of(context).primaryColor,
                              icon: Icon(Icons.search, color: Colors.white,),
                              label:  Text('Buscar', style: TextStyle(color: Colors.white),),
                              onPressed: (){
                                
                                List<int> aux = _textEditingControllerDtEntrega.text.split('/').map((String v) => int.parse(v)).toList();

                                itemRotaBloc.getLeiteC(
                                  datEmi: DateTime(aux[2], aux[1], aux[0]),
                                  rota:  rotaBloc.rotaSelecionada.codRoe
                                ).then((total) {
                                  print('TOTAL DE LEITE C ENCONTRADO $total');
                                  _textEditingControllerTotal.text = total.toString();
                                  _textEditingControllerComissao.text = (total/100.0).floor().toString();
                                }).catchError((err) {
                                  print("HOUVE UM ERRO $err");
                                });

                              },
                            )
                          ],
                        ),
                    ),


                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            enabled: false,
                            controller: _textEditingControllerComissao,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'COMISSÃO'
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0,),

                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'CXS. RETORNADAS'
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0,),

                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            enabled: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'SALDO DE CAIXAS'
                            ),
                          ),
                        ),
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
                            child: StreamBuilder(
                              stream: transacaoBloc.tnsStream,
                              builder: (context, snapshot){
                                if(!snapshot.hasData) {
                                  transacaoBloc.listAll();
                                  return LinearProgressIndicator();
                                }

                                var transacoes = transacaoBloc.getTransacoes();

                                return DropdownButtonFormField<Transacao>(
                                  value: transacaoBloc.tnsSelecionada,
                                  decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 17.5, horizontal: 8)),
                                  hint: Text('TRANSAÇÃO', style: TextStyle(fontWeight: FontWeight.bold),),
                                  onChanged: (Transacao tns){
                                    // rotaBloc.select(rota);
                                    transacaoBloc.select(tns);
                                  },
                                  items:  transacoes.map<DropdownMenuItem<Transacao>>((Transacao tns){
                                    return DropdownMenuItem<Transacao>(
                                      value: tns,
                                      child: Text('${tns.codTns}'),
                                    );
                                  }).toList(),
                                );
                              },
                            )
                          )

                          // Expanded(
                          //   flex: 5,
                          //     child: DropdownButtonFormField<String>(
                          //     decoration: InputDecoration(
                          //       contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
                          //     ),
                          //     hint: Text('TRANSAÇÃO'),
                          //     items: _menuTns,
                          //     value: _modelProduto.codTns,
                          //     onChanged: (String value) {
                          //         setState(() {
                          //           _modelProduto.codTns = value;
                          //         });
                          //     },
                          //   ),
                          // )
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

                              // subtraindo da comissão
                              var comissao = int.parse(_textEditingControllerComissao.text);
                              
                              if(_modelProduto.codPro == '010.01') {
                                comissao -= _modelProduto.qtd;
                              }
                              _textEditingControllerComissao.text = comissao.toString();
                              // adicionando mais um produto
                              _modelProduto.codTns = transacaoBloc.tnsSelecionada.codTns;
                              itemRotaBloc.addProduto(_modelProduto);
                              _modelProduto = Produto();
                              transacaoBloc.select(null);

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
                          

                          if(produtos.length == 0) {
                            return Text('NENUM PRODUTO ADICIONADO');
                          }

                          List<Column> _children = [];

                          produtos.asMap().forEach((int index, Produto produto) => {
                            _children.add(
                              Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Colors.grey[200],
                                    ),
                                    child: Dismissible(
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (DismissDirection direction) {
                                        print('Item removido');
                                        print(index);
                                        itemRotaBloc.removeProduto(index);
                                      },
                                      background: Container(color: Colors.red, child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[Icon(Icons.remove_circle, color: Colors.white,), SizedBox(width: 20,)],)),
                                      key: ValueKey('${produto.codPro}${produto.qtd}${produto.codTns}'),
                                      child: ListTile(
                                        title: Text(produto.codPro),
                                        subtitle: Text('Quantidade: ${produto.qtd} | Transação: ${produto.codTns}'),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            )
                          });

                          return Column(
                            children: _children,
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