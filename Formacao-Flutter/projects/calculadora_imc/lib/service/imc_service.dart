import '../models/pessoa.dart';

class IMCService {
  static void exibirResultado(Pessoa pessoa) {
    var imc = calcularIMC(pessoa.getPeso(), pessoa.getAltura());
    var classificacaoIMC = classificarIMC(imc);
    print(
        "\n--> ${pessoa.getNome()}, você possui um IMC de ${imc.toStringAsFixed(1)}, o qual é classificado como $classificacaoIMC.");
  }

  static double calcularIMC(double peso, double altura) {
    if (peso <= 0) {
      throw ArgumentError("O peso deve ser maior que zero");
    }
    if (altura <= 0) {
      throw ArgumentError("A altura deve ser maior que zero");
    }
    altura = altura / 100;
    return (peso / (altura * altura));
  }

  static String classificarIMC(double imc) {
    if (imc < 16) {
      return "MAGREZA GRAVE";
    } else if (imc < 17) {
      return "MAGREZA MODERADA";
    } else if (imc < 18.5) {
      return "MAGREZA LEVE";
    } else if (imc < 25) {
      return "SALDÁVEL";
    } else if (imc < 30) {
      return "SOBREPESO";
    } else if (imc < 35) {
      return "OBESIDADE GRAU I";
    } else if (imc < 40) {
      return "OBESIDADE GRAU II (SEVERA)";
    } else if (imc >= 40) {
      return "OBESIDADE GRAU III (MÓRBIDA)";
    } else {
      return "Intervalo não especificado";
    }
  }
}
