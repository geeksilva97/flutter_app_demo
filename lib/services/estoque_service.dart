import 'package:dio/dio.dart';

class EstoqueService {

  Future<dynamic> listaRotas() async {
    print("Service buscando rotas");
    try {
      Response response = await Dio().get('http://localhost:5000');
      print(response);
    }catch(e){
      print(e);
    }
  }
  
}