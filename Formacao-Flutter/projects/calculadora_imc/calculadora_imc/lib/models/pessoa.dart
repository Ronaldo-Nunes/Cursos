// ignore_for_file: unused_import

import 'dart:ffi';

class Pessoa {
  String _nome = "";
  double _peso = 0;
  double _altura = 0;

  void setNome(String nome) {
    _nome = nome;
  }

  String getNome() => _nome;

  void setPeso(double peso) {
    _peso = peso;
  }

  double getPeso() => _peso;

  void setAltura(double altura) {
    _altura = altura;
  }

  double getAltura() => _altura;
}
