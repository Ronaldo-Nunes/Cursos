import 'dart:convert' show utf8;
import 'dart:io';

class ConsoleUtils {
  static String lerStringComMensagem(String mensagem) {
    stdout.write(mensagem);
    return lerString();
  }

  static String lerString() {
    return stdin.readLineSync(encoding: utf8) ?? "";
  }

  static double? lerDouble() {
    var valor = lerString();
    return double.tryParse(valor);
  }

  static double? lerDoubleComMensagemComSaida(
      String mensagem, String valorSaida) {
    do {
      try {
        var value = lerStringComMensagem(mensagem);
        if (value == valorSaida) {
          return null;
        }
        return double.parse(value);
      } catch (e) {
        stdout.write(mensagem);
      }
    } while (true);
  }

  static double? lerDoubleComMensagem(String mensagem) {
    stdout.write(mensagem);
    return lerDouble();
  }
}
