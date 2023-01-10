import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc_flutter_app/model/avaliacao_imc.dart';
import 'package:imc_flutter_app/repositories/imc_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late TextEditingController _pesoController;
  late TextEditingController _alturaController;
  final _imcRepository = ImcRepository();
  var _avaliacoes = <AvaliacaoIMC>[];

  @override
  void initState() {
    _alturaController = TextEditingController();
    _pesoController = TextEditingController();
    super.initState();

    listarAvaliacoes();
  }

  void listarAvaliacoes() async {
    var listaImc = await _imcRepository.listar();
    _avaliacoes = listaImc;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibirFormAvaliacao();
        },
        child: const Icon(Icons.add),
      ),
      body: _avaliacoes.isEmpty
          ? const Center(child: Text("Não há avaliações cadastradas."))
          : ListView.separated(
              itemCount: _avaliacoes.length,
              itemBuilder: (BuildContext bc, int index) {
                var avaliacao = _avaliacoes[index];
                return Dismissible(
                    background: Container(
                      color: const Color.fromARGB(255, 170, 31, 21),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (DismissDirection dismissDirection) async {
                      await _imcRepository.excluir(avaliacao.id);
                      listarAvaliacoes();
                    },
                    key: Key(avaliacao.id),
                    child: InkWell(
                        child: ListTile(
                          isThreeLine: true,
                          leading: CircleAvatar(
                              backgroundImage: AssetImage(avaliacao.image)),
                          title: Text(avaliacao.classificaoImc),
                          subtitle: Text(
                            "IMC: ${avaliacao.imc.toStringAsFixed(1)}\n${avaliacao.peso} Kg | ${(avaliacao.altura / 100)} m",
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: Text(
                            avaliacao.data,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        onTap: () {
                          _exibirFormAvaliacao(avaliacao: avaliacao);
                        })); //ImcItem(avaliacaoIMC: avaliacao));
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                );
              }),
    );
  }

  void _exibirFormAvaliacao({AvaliacaoIMC? avaliacao}) {
    if (avaliacao != null) {
      _alturaController.text = avaliacao.altura.toString();
      _pesoController.text = avaliacao.peso.toString();
    } else {
      avaliacao = null;
      _limparCampos();
    }
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(
                avaliacao == null ? "Nova Avaliação" : "Atualizar avaliação"),
            content: Wrap(children: [
              Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        filled: true, labelText: "Altura (em centímetros)"),
                    controller: _alturaController,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        filled: true, labelText: "Peso (em Kg)"),
                    controller: _pesoController,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ]),
            actions: [
              TextButton(
                  onPressed: () {
                    _limparCampos();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                    if (camposValidados()) {
                      salvar(avaliacao: avaliacao);
                    }
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          );
        });
  }

  void salvar({AvaliacaoIMC? avaliacao}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var pesoStr = _pesoController.text.trim();
    var alturaStr = _alturaController.text.trim();

    var altura = double.tryParse(alturaStr) ?? 0;
    var peso = double.tryParse(pesoStr) ?? 0;

    if (avaliacao == null) {
      await _imcRepository.adicionar(AvaliacaoIMC(altura, peso));
    } else {
      avaliacao.altura = altura;
      avaliacao.peso = peso;
      avaliacao.calcularImc();
      await _imcRepository.atualizar(avaliacao);
    }

    Navigator.pop(context);
    setState(() {});
    _limparCampos();
  }

  void exibirAlerta(String mensagem) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text("Revise o dado informado"),
            content: Text(mensagem),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  bool camposValidados() {
    var pesoStr = _pesoController.text.trim();
    var alturaStr = _alturaController.text.trim();

    if (alturaStr.isEmpty && pesoStr.isEmpty) {
      exibirAlerta("Preencha todos os campos!");
      return false;
    }

    if (alturaStr.isEmpty) {
      exibirAlerta("Informe a altura!");
      return false;
    }

    if (pesoStr.isEmpty) {
      exibirAlerta("Informe o peso!");
      return false;
    }

    var altura = double.tryParse(alturaStr) ?? 0;
    var peso = double.tryParse(pesoStr) ?? 0;

    if (altura < 30 || altura > 300) {
      exibirAlerta("A altura deve ser maior que 30cm e menor que 300cm!");
      return false;
    }

    if (peso < 0 || peso > 700) {
      exibirAlerta("O peso deve ser maior que 0 e menor que 700Kg!");
      return false;
    }
    return true;
  }

  void _limparCampos() {
    _alturaController.text = "";
    _pesoController.text = "";
  }
}
