import 'dart:async';
import 'dart:convert';

import 'package:estoque_app/models/transacao.dart';
import 'package:http/http.dart' as http;

class TransacaoBloc {

  final String _baseURL = 'http://192.168.0.4:5200/api';
  List<Transacao> _tns = [];
  Transacao _tnsSelecionada;
  final _controller = StreamController();

  Stream get tnsStream => _controller.stream;
  Transacao get tnsSelecionada => _tnsSelecionada;
  List<Transacao> getTransacoes() => _tns;


  void listAll() async {
    String url = _baseURL+'/general/tns';
    var response = await http.get(url);
    var json = jsonDecode(response.body) as List<dynamic>;
    _tns = json.map((map) => Transacao.fromJson(map)).toList();
    _controller.sink.add(_tns);
  }

  void select(Transacao transacao) {
    _tnsSelecionada = transacao;
    _controller.sink.add(_tns);
  }

  void dispose() {
    _controller.close();
  }
}

var transacaoBloc = TransacaoBloc();