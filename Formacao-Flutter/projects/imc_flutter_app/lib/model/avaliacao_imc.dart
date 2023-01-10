import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AvaliacaoIMC {
  final String _id = UniqueKey().toString();
  final String _data = DateFormat("dd/MM/yy").format(DateTime.now());
  String _image = "";
  double altura = 0;
  double peso = 0;
  double _imc = 0;
  String _classificaoImc = "";

  AvaliacaoIMC(this.altura, this.peso) {
    calcularImc();
  }

  void calcularImc() {
    _setImc();
    _setClassificacaoImc();
  }

  String get id => _id;

  String get data => _data;

  double get imc => _imc;

  String get image => _image;

  String get classificaoImc => _classificaoImc;

  void _setImc() {
    if ((altura > 0 && altura < 300) && (peso > 0 && peso < 700)) {
      var alt = altura / 100;
      _imc = (peso / (alt * alt));
    } else {
      _imc = 0;
    }
  }

  void _setClassificacaoImc() {
    if (_imc < 16) {
      _image = 'lib/images/magreza_grave.png';
      _classificaoImc = "Magreza grave";
    } else if (_imc < 17) {
      _image = "lib/images/magreza_moderada.png";
      _classificaoImc = "Magreza moderada";
    } else if (_imc < 18.5) {
      _image = "lib/images/magreza_leve.png";
      _classificaoImc = "Magreza leve";
    } else if (_imc < 25) {
      _image = "lib/images/saudavel.png";
      _classificaoImc = "Saldável";
    } else if (_imc < 30) {
      _image = "lib/images/sobrepeso.png";
      _classificaoImc = "Sobrepeso";
    } else if (_imc < 35) {
      _image = "lib/images/obesidade_grau_i.png";
      _classificaoImc = "Obesidade grau I";
    } else if (_imc < 40) {
      _image = "lib/images/obesidade_grau_ii.png";
      _classificaoImc = "Obesidade grau II (Severa)";
    } else if (_imc >= 40) {
      _image = "lib/images/obesidade_grau_iii.png";
      _classificaoImc = "Obesidade grau III (Mórbida)";
    }
  }
}
