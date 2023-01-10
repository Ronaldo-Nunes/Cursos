import 'package:imc_flutter_app/model/avaliacao_imc.dart';

class ImcRepository {
  final List<AvaliacaoIMC> _avaliacoes = [];

  Future<void> adicionar(AvaliacaoIMC avaliacaoIMC) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _avaliacoes.add(avaliacaoIMC);
  }

  Future<void> atualizar(AvaliacaoIMC avaliacaoIMC) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _avaliacoes
        .where((avaliacao) => avaliacao.id == avaliacaoIMC.id)
        .first
        .altura = avaliacaoIMC.altura;

    _avaliacoes
        .where((avaliacao) => avaliacao.id == avaliacaoIMC.id)
        .first
        .peso = avaliacaoIMC.peso;
  }

  Future<void> excluir(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    _avaliacoes
        .remove(_avaliacoes.where((avaliacao) => avaliacao.id == id).first);
  }

  Future<List<AvaliacaoIMC>> listar() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _avaliacoes;
  }
}
