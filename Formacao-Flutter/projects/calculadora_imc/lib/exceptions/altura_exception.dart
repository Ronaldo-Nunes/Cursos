class AlturaInvalidaException implements Exception {
  String error() => "Altura inválida";

  String message() =>
      "A altura (em centímetros) deve ser maior que 0 e menor que 270";

  @override
  String toString() {
    return "AlturaInvalidaException: ${error()}";
  }
}
