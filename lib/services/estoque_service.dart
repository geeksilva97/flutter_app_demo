import 'package:dio/dio.dart';

class EstoqueService {

  Future<dynamic> listaRotas() async {
    print("\n\n\n\n ------------- Service buscando rotas --------------- \n\n\n\n");
    try {
      Response response = await Dio().get('http://192.168.0.4:5200/api/estoque-app/rotas');
      print("\n\n\n\n ------------- RESPOSTA DIO --------------- \n\n\n\n");
      print(response);
      Future.value(response);
    }catch(e){
      print("\n\n\n\n ------------- ERRO DIO --------------- \n\n\n\n");
      Future.error(e);
      print(e);
    }
  }
  
}