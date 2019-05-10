
import 'package:estoque_app/models/produto.dart';

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


    String toString() {
      return '$rota - ${produtos.length}';
    }
}