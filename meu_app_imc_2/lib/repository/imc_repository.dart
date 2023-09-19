import 'package:meu_app_imc_2/models/imc.dart';

class IMCRepository {
  final List<IMC> _resultados = [];

  void adicionar(double altura, double peso, String resultado) {
    IMC resposta = IMC(peso, altura, resultado);
    _resultados.add(resposta);
  }

  void remover(String id) {
    _resultados.remove(_resultados.where((res) => res.id == id).first);
  }

  List<IMC> listaResultados() {
    return _resultados;
  }
}
