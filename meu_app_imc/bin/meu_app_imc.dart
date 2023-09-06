import 'dart:convert';
import 'dart:io';

import 'package:meu_app_imc/calcula_imc.dart';
import 'package:meu_app_imc/models/pessoa.dart';

void main(List<String> arguments) {
  try {
    print("Digite o nome da pessoa:");
    String nome = stdin.readLineSync()!;

    print("Digite o peso da pessoa (em kg):");
    double peso = double.parse(stdin.readLineSync(encoding: utf8)!);

    print("Digite a altura da pessoa (em metros):");
    double altura = double.parse(stdin.readLineSync(encoding: utf8)!);

    Pessoa pessoa = Pessoa(nome, peso, altura);

    double imc = calcularIMC(pessoa.peso, pessoa.altura);

    print("Nome: ${pessoa.nome}");
    print("Peso: ${pessoa.peso} kg");
    print("Altura: ${pessoa.altura} m");
    print("IMC: $imc");

    if (imc < 16) {
      print("Magreza grave");
    } else if (imc < 17) {
      print("Magreza moderada");
    } else if (imc < 18.5) {
      print("Magreza leve");
    } else if (imc < 24.9) {
      print("Saudável");
    } else if (imc < 29.9) {
      print("Sobrepeso");
    } else if (imc < 34.9) {
      print("Obesidade grau 1");
    } else if (imc < 39.9) {
      print("Obesidade grau 2");
    } else {
      print("Obesidade grau 3");
    }
  } catch (e) {
    print("Dados inválidos. Erro: $e");
  }
}
