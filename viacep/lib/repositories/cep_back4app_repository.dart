import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:viacep/models/cadastro_cep.dart';

class CepBack4AppRepository {
  final _dio = Dio();
  var url = "/cep";

  CepBack4AppRepository() {
    _dio.options.headers["X-Parse-Application-Id"] =
        dotenv.get("BACK4APP_PARSE_APPLICATION_ID");

    _dio.options.headers["X-Parse-REST-API-Key"] =
        dotenv.get("BACK4APP_PARSE_REST_API_KEY");

    _dio.options.baseUrl = "https://parseapi.back4app.com/classes";
  }
  Future<CadastroCepModel> get() async {
    var response = await _dio.get(url);
    return CadastroCepModel.fromJson(response.data);
  }

  Future<void> create(Results results) async {
    try {
      await _dio.post("$url/${results.objectId}",
          data: results.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> edit(Results results) async {
    try {
      await _dio.put("$url/${results.objectId}",
          data: results.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String objectId) async {
    try {
      await _dio.delete("$url/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
