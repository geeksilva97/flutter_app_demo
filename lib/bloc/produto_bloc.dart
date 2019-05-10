import 'dart:async';

import 'package:estoque_app/models/produto.dart';

class ProdutoBloc {
  Produto produto = Produto();

  final StreamController controller = StreamController();
  Stream get getProdutoStream => controller.stream;

  void setProduto(Produto produto) {
    produto = produto;
    controller.sink.add(produto);
  }

  void dispose() {
    controller.close();
  }
}

var produtoBloc = ProdutoBloc();