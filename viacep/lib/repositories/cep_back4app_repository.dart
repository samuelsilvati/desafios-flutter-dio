import 'package:dio/dio.dart';
import 'package:viacep/models/cadastro_cep.dart';

class CepBack4AppRepository {
  Future<CadastroCepModel> get() async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] = "";
    dio.options.headers["X-Parse-REST-API-Key"] = "";
    var result = await dio.get("https://parseapi.back4app.com/classes/cep");
    return CadastroCepModel.fromJson(result.data);
  }
}
