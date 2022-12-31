import 'package:calculadora_imc/utils/console_utils.dart';

int calculate() {
  return 6 * 7;
}

void execute() {
  print("Bem-vindo à Calculadora de IMC em Dart!!!");

  var nome = "";
  do {
    nome = ConsoleUtils.lerStringComMensagem("Informe seu nome: ");
  } while (nome.isEmpty);
}

double calcularIMC(double peso, double altura) {
  altura = altura / 100;
  return (peso / (altura * altura)).roundToDouble();
}

String classificarIMC(double imc) {
  if (imc < 16) {
    return "magreza grave";
  } else if (imc < 17) {
    return "magreza moderada";
  } else if (imc < 18.5) {
    return "magreza leve";
  } else if (imc < 25) {
    return "saldável";
  } else if (imc < 30) {
    return "sobrepeso";
  } else if (imc < 35) {
    return "obesidade grau I";
  } else if (imc < 40) {
    return "obesidade grau II (severa)";
  } else if (imc >= 40) {
    return "obesidade grau III (mórbida)";
  } else {
    return "Intervalo não especificado";
  }
}

void exibirResultado(String nome, double imc, String classificacaoIMC) {
  print(
      "$nome possui um IMC de ${imc.toStringAsFixed(1)}, o qual é classificado como $classificacaoIMC.");
}
