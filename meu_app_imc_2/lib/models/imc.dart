import 'package:flutter/material.dart';

class IMC {
  final String _id = UniqueKey().toString();
  double _peso;
  double _altura;
  String _resultado;

  IMC(this._peso, this._altura, this._resultado);

  String get id => _id;

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }

  String get resultado => _resultado;

  set resultado(String resultado) {
    _resultado = resultado;
  }
}
