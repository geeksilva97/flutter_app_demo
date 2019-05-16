import 'dart:async';
import 'dart:convert';

import 'package:estoque_app/models/rota.dart';
import 'package:http/http.dart' as http;

class RotaBloc {
  String _baseURL = 'http://192.168.0.4:5200/api';
  List<Rota> _rotas = [];
  Rota _rotaSelecionada;
  final _controller = StreamController();

  Stream get rotaStream => _controller.stream;

  // methods
  void listAll() async {
    String url = _baseURL + '/general/rotas';
    var response = await http.get(url);
    var json = jsonDecode(response.body) as List<dynamic>;
    _rotas = json.map((map) => Rota.fromJson(map)).toList();
    _controller.sink.add(_rotas);
  }

  void select(Rota rota) {
    _rotaSelecionada = rota;
    _controller.sink.add(_rotas);
  }

  List<Rota> getRotas() => _rotas;
  Rota get rotaSelecionada => _rotaSelecionada;

  void dispose() {
    _controller.close();
  }

}

var rotaBloc = RotaBloc();