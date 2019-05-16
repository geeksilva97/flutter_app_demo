import 'dart:async';
import 'dart:convert';
import 'package:estoque_app/models/item_rota.dart';
import 'package:estoque_app/models/produto.dart';
import 'package:http/http.dart' as http;

class ItemRotaBloc {
  ItemRota _itemRota = ItemRota(
    produtos: []
  );

  double _qtdLeiteC = 0;

  final _controller = StreamController();
  Stream get getItemRotaStream => _controller.stream;

  double get totalLeiteC => _qtdLeiteC;


  void addProduto(Produto produto) {
    _itemRota.produtos.add(produto);
    _controller.sink.add(_itemRota);
    print(_itemRota.produtos.length);
    for (var produto in _itemRota.produtos) {
      print('${produto.codPro} - ${produto.qtd} - ${produto.codTns}');
    }
  }

  void removeProduto(int index) {
    _itemRota.produtos.removeAt(index);
    _controller.sink.add(_itemRota) ;
  }

  Future<double> getLeiteC({DateTime datEmi, String rota}) async {
    String dat = '${datEmi.year}-${datEmi.month}-${datEmi.day}';


    var response = await http.post(
      'http://192.168.0.4:5200/api/estoque-app/leitec/$rota',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "codEmp": '1',
        "Codfil": '1',
        "CodSnf": "NFE",
        "DatEmi": dat,
      })
    );

    var json = jsonDecode(response.body);
    var total = json['total'] as double;
    _qtdLeiteC = total;
    return Future.value(total);
  }

  List<Produto> getProdutos() => _itemRota.produtos;

  void dispose() {
    _controller.close();
  }
  
}

var itemRotaBloc = ItemRotaBloc();