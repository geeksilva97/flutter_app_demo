import 'package:dio/dio.dart';
import 'package:estoque_app/models/rota.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:estoque_app/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {

  final baseUrl = 'http://192.168.0.4:5200/api';

  test('json serialization test', () async {   

    var url = baseUrl+'/values';
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    var json = jsonDecode(response.body) as List<dynamic>;
    print(json.runtimeType);

    expect("value1", json[0]);
    expect("value2", json[1]);
    expect(json.length, 2);

  });


  test('rotas test', () async {
    var url = baseUrl+'/general/rotas';
    var response = await http.get(url);

    expect(response.statusCode, 200);
    
    // serialize json
    var json = jsonDecode(response.body) as List<dynamic>;
    var lista = json.map((value) => Rota.fromJson(value)).toList();

    print(lista[0].codRoe);

    expect(json.length > 0, true);
    expect(lista.length > 0, true);
  });
}