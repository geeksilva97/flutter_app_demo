
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {

  final baseUrl = 'http://192.168.0.4:5200/api';


  test('quantidade de leite c', () async {
    var url = baseUrl+'/estoque-app/leitec/03';
    var response = await http.post(url, 
      headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
      {
        "codEmp": '1',
        "Codfil": '1',
        "CodSnf": "NFE",
        "DatEmi": "2019-02-14",
      }
    ));

    expect(response.statusCode, 200);
    
    // serialize json
    var json = jsonDecode(response.body);
    var total =json['total'] as double;
    expect(total, 1250.0);
    

  });
}