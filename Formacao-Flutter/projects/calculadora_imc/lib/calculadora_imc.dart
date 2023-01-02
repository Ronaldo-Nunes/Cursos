import 'dart:io';

import 'package:calculadora_imc/exceptions/peso_exception.dart';
import 'package:calculadora_imc/models/pessoa.dart';
import 'package:calculadora_imc/service/imc_service.dart';
import 'package:calculadora_imc/utils/console_utils.dart';

import 'exceptions/altura_exception.dart';

int calculate() {
  return 6 * 7;
}

void execute() {
  print("\nBem-vindo à Calculadora de IMC em Dart!!!\n");

  String nome;
  do {
    nome = ConsoleUtils.lerStringComMensagem("## Informe seu nome: ");
  } while (nome.trim().isEmpty);

  var pessoa = Pessoa(nome);

  double? peso;
  do {
    try {
      peso = ConsoleUtils.lerDoubleComMensagemComSaida(
          "## Informe o seu peso (EM KG) ou digite 'S' para sair: ", "S");
      if (peso != null) {
        if (peso <= 0 || peso > 600) {
          throw PesoInvalidoException();
        } else {
          pessoa.setPeso(peso);
        }
      }
    } on PesoInvalidoException {
      print(PesoInvalidoException().message());
      peso = null;
    } catch (e) {
      print(e);
      exit(0);
    }
  } while (peso == null);

  double? altura;
  do {
    try {
      altura = ConsoleUtils.lerDoubleComMensagemComSaida(
          "## Informe a sua altura (EM CENTÍMETROS) ou digite 'S' para sair: ",
          "S");
      if (altura != null) {
        if (altura <= 50 || altura > 270) {
          throw AlturaInvalidaException();
        } else {
          pessoa.setAltura(altura);
        }
      }
    } on AlturaInvalidaException {
      print(AlturaInvalidaException().message());
      altura = null;
    } catch (e) {
      print(e);
      exit(0);
    }
  } while (altura == null);

  print("\n--> Valoles informados: $pessoa.");
  if (pessoa.isFilled()) {
    IMCService.exibirResultado(pessoa);
  }
}
