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

  static double? lerDoubleComMensagemComSaida(
      String mensagem, String valorSaida) {
    do {
      String? value;
      try {
        value = lerStringComMensagem(mensagem);
        if (value.toUpperCase() == valorSaida) {
          exit(0);
        }
        value = value.replaceAll(",", ".");
        return double.parse(value);
      } catch (e) {
        print("O valor informado é inválido: $value");
      }
    } while (true);
  }
}
