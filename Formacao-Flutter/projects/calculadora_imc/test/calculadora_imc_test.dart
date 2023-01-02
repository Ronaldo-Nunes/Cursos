import 'package:calculadora_imc/service/imc_service.dart';
import 'package:test/test.dart';

void main() {
  test('Calcula o valor do IMC de uma pessoa de 100Kg e 2m de altura', () {
    expect(IMCService.calcularIMC(100, 200), equals(25));
  });

  test('Calcula o valor do IMC de uma pessoa de 100Kg e 0m de altura', () {
    expect(() => IMCService.calcularIMC(100, 0),
        throwsA(TypeMatcher<ArgumentError>()));
  });

  test('Calcula o valor do IMC de uma pessoa de 0Kg e 2m de altura', () {
    expect(() => IMCService.calcularIMC(0, 200),
        throwsA(TypeMatcher<ArgumentError>()));
  });

  group("Calcula a classificação do IMC", () {
    var valuesToTest = {
      {'imc': 14}: 'MAGREZA GRAVE',
      {'imc': 16.5}: 'MAGREZA MODERADA',
      {'imc': 18.4}: 'MAGREZA LEVE',
      {'imc': 24}: 'SALDÁVEL',
      {'imc': 29}: 'SOBREPESO',
      {'imc': 33}: 'OBESIDADE GRAU I',
      {'imc': 36.5}: 'OBESIDADE GRAU II (SEVERA)',
      {'imc': 40.1}: 'OBESIDADE GRAU III (MÓRBIDA)'
    };
    valuesToTest.forEach((value, expected) {
      test('Entrada: $value Esperado: $expected', () {
        expect(IMCService.classificarIMC(double.parse(value['imc'].toString())),
            equals(expected));
      });
    });
  });
}
