import 'package:meu_app_imc_2/service/calcula_imc.dart';

String calculaResultadoFinal(double peso, double altura) {
  double resultado = calcularIMC(peso, altura);

  String resultadoFormatado = resultado.toStringAsFixed(2);
  if (resultado < 16) {
    return "$resultadoFormatado Magreza grave";
  } else if (resultado < 17) {
    return "$resultadoFormatado Magreza moderada";
  } else if (resultado < 18.5) {
    return "$resultadoFormatado Magreza leve";
  } else if (resultado < 24.9) {
    return "$resultadoFormatado Saudável";
  } else if (resultado < 29.9) {
    return "$resultadoFormatado Sobrepeso";
  } else if (resultado < 34.9) {
    return "$resultadoFormatado Obesidade grau 1";
  } else if (resultado < 39.9) {
    return "$resultadoFormatado Obesidade grau 2";
  } else {
    return "$resultadoFormatado Obesidade grau 3";
  }
}
