import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:viacep/models/viacep_model.dart';

class ViaCepRepository {
  Future<ViacepModel> consultarCEP(String cep) async {
    var response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));

    var json = jsonDecode(response.body);
    return ViacepModel.fromJson(json);
  }
}
