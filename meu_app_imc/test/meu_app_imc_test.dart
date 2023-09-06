import 'package:meu_app_imc/calcula_imc.dart';
import 'package:meu_app_imc/models/pessoa.dart';
import 'package:test/test.dart';

void main() {
  group('Testes do Cálculo do IMC', () {
    test('Teste 1: IMC Magreza Grave', () {
      Pessoa pessoa = Pessoa('Luís', 45, 1.75);
      double imc = calcularIMC(pessoa.peso, pessoa.altura);
      expect(imc, lessThan(16));
    });

    test('Teste 2: IMC Magreza Moderada', () {
      Pessoa pessoa = Pessoa('Julia', 50, 1.75);
      double imc = calcularIMC(pessoa.peso, pessoa.altura);
      expect(imc, greaterThanOrEqualTo(16));
      expect(imc, lessThan(17));
    });

    test('Teste 3: IMC Magreza leve', () {
      Pessoa pessoa = Pessoa('João', 50, 1.70);
      double imc = calcularIMC(pessoa.peso, pessoa.altura);
      expect(imc, lessThan(18.5));
    });

    test('Teste 4: IMC Saudável', () {
      Pessoa pessoa = Pessoa('Maria', 65, 1.75);
      double imc = calcularIMC(pessoa.peso, pessoa.altura);
      expect(imc, greaterThanOrEqualTo(18.5));
      expect(imc, lessThan(24.9));
    });

    test('Teste 5: IMC Sobrepeso', () {
      Pessoa pessoa = Pessoa('Pedro', 81, 1.80);
      double imc = calcularIMC(pessoa.peso, pessoa.altura);
      expect(imc, greaterThanOrEqualTo(24.9));
      expect(imc, lessThan(29.9));
    });

    test('Teste 6: IMC Obesidade Grau 1', () {
      Pessoa pessoa = Pessoa('Ana', 95, 1.65);
      double imc = calcularIMC(pessoa.peso, pessoa.altura);
      expect(imc, greaterThanOrEqualTo(29.9));
      expect(imc, lessThan(34.9));
    });

    test('Teste 7: IMC Obesidade Grau 2', () {
      Pessoa pessoa = Pessoa('Carlos', 110, 1.75);
      double imc = calcularIMC(pessoa.peso, pessoa.altura);
      expect(imc, greaterThanOrEqualTo(34.9));
      expect(imc, lessThan(39.9));
    });

    test('Teste 8: IMC Obesidade Grau 3', () {
      Pessoa pessoa = Pessoa('Marta', 140, 1.70);
      double imc = calcularIMC(pessoa.peso, pessoa.altura);
      expect(imc, greaterThanOrEqualTo(39.9));
    });
  });
}
