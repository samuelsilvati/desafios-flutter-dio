import 'package:flutter_test/flutter_test.dart';
import 'package:meu_app_imc_2/models/imc.dart';
import 'package:meu_app_imc_2/service/calcula_imc.dart';

void main() {
  group('Testes do Cálculo do IMC', () {
    test('Teste 1: IMC Magreza Grave', () {
      IMC imc = IMC(45, 1.75, '');
      double resultadoImc = calcularIMC(imc.peso, imc.altura);
      expect(resultadoImc, lessThan(16));
    });

    test('Teste 2: IMC Magreza Moderada', () {
      IMC imc = IMC(50, 1.75, '');
      double resultadoImc = calcularIMC(imc.peso, imc.altura);
      expect(resultadoImc, greaterThanOrEqualTo(16));
      expect(resultadoImc, lessThan(17));
    });

    test('Teste 3: IMC Magreza leve', () {
      IMC imc = IMC(50, 1.70, '');
      double resultadoImc = calcularIMC(imc.peso, imc.altura);
      expect(resultadoImc, lessThan(18.5));
    });

    test('Teste 4: IMC Saudável', () {
      IMC imc = IMC(65, 1.75, '');
      double resultadoImc = calcularIMC(imc.peso, imc.altura);
      expect(resultadoImc, greaterThanOrEqualTo(18.5));
      expect(resultadoImc, lessThan(24.9));
    });

    test('Teste 5: IMC Sobrepeso', () {
      IMC imc = IMC(81, 1.80, '');
      double resultadoImc = calcularIMC(imc.peso, imc.altura);
      expect(resultadoImc, greaterThanOrEqualTo(24.9));
      expect(resultadoImc, lessThan(29.9));
    });

    test('Teste 6: IMC Obesidade Grau 1', () {
      IMC imc = IMC(95, 1.65, '');
      double resultadoImc = calcularIMC(imc.peso, imc.altura);
      expect(resultadoImc, greaterThanOrEqualTo(29.9));
      expect(resultadoImc, lessThan(34.9));
    });

    test('Teste 7: IMC Obesidade Grau 2', () {
      IMC imc = IMC(110, 1.75, '');
      double resultadoImc = calcularIMC(imc.peso, imc.altura);
      expect(resultadoImc, greaterThanOrEqualTo(34.9));
      expect(resultadoImc, lessThan(39.9));
    });

    test('Teste 8: IMC Obesidade Grau 3', () {
      IMC imc = IMC(140, 1.70, '');
      double resultadoImc = calcularIMC(imc.peso, imc.altura);
      expect(resultadoImc, greaterThanOrEqualTo(39.9));
    });
  });
}
