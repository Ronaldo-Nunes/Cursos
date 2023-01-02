class PesoInvalidoException implements Exception {
  String error() => "Peso inválido";

  String message() =>
      "O peso (em quilogramas) deve ser maior que 0 e menor que 600";

  @override
  String toString() {
    return "PesoInvalidoException: ${error()}";
  }
}
