import 'dart:async';
import 'package:estoque_app/models/item_rota.dart';
import 'package:estoque_app/models/produto.dart';

class ItemRotaBloc {
  ItemRota _itemRota = ItemRota(
    produtos: []
  );

  final _controller = StreamController();
  Stream get getItemRotaStream => _controller.stream;


  void addProduto(Produto produto) {
    _itemRota.produtos.add(produto);
    _controller.sink.add(_itemRota);
    print(_itemRota.produtos.length);
    for (var produto in _itemRota.produtos) {
      print('${produto.codPro} - ${produto.qtd} - ${produto.codTns}');
    }
  }

  List<Produto> getProdutos() => _itemRota.produtos;

  void dispose() {
    _controller.close();
  }
  
}

var itemRotaBloc = ItemRotaBloc();