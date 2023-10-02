import 'package:flutter/material.dart';
import 'package:meu_app_imc_2/models/imc_hive_model.dart';
import 'package:meu_app_imc_2/repository/imc_hive_repository.dart';
import 'package:meu_app_imc_2/service/calcula_resultado_final.dart';

class MyHomePageHive extends StatefulWidget {
  const MyHomePageHive({super.key});

  @override
  State<MyHomePageHive> createState() => _MyHomePageHiveState();
}

class _MyHomePageHiveState extends State<MyHomePageHive> {
  var altura = TextEditingController();
  var peso = TextEditingController();

  late IMCHiveRepository imcHiveRepository;
  var _resultadoFinal = const <IMCHiveModel>[];

  void calculaIMC() {
    final novaAltura = altura.text.replaceAll(',', '.');
    double alturaDouble = double.parse(novaAltura);
    double pesoDouble = double.parse(peso.text);

    String resultadoImc = calculaResultadoFinal(pesoDouble, alturaDouble);

    imcHiveRepository
        .salvar(IMCHiveModel.criar(pesoDouble, alturaDouble, resultadoImc));
  }

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  void obterIMC() async {
    imcHiveRepository = await IMCHiveRepository.carregar();
    _resultadoFinal = imcHiveRepository.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Calculadora de IMC"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text("Clique no botão abaixo para calcular o IMC"),
                ))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _resultadoFinal.length,
            itemBuilder: (context, index) {
              var imcData = _resultadoFinal[index];
              return Card(
                child: ListTile(
                  title: Text(
                      "Peso ${imcData.peso}Kg | Altura ${imcData.altura}m"),
                  subtitle: Text("IMC: ${imcData.resultado}"),
                  trailing: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext bc) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: const Icon(
                                Icons.warning,
                                size: 32,
                                color: Colors.redAccent,
                              ),
                              content: const Wrap(
                                children: [
                                  Text("Deseja realmente apagar o IMC?"),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Não')),
                                TextButton(
                                    onPressed: () {
                                      imcHiveRepository.excluir(imcData);
                                      Navigator.pop(context);
                                      obterIMC();
                                    },
                                    child: const Text('Sim'))
                              ],
                            );
                          });
                    },
                    child: const Icon(Icons.delete),
                  ),
                ),
              );
            },
          )),
          const SizedBox(
            height: 90,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          altura.text = "";
          peso.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Calcular IMC"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(hintText: "Peso em kg"),
                        controller: peso,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(hintText: "Altura em metros"),
                        controller: altura,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar')),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          calculaIMC();
                          obterIMC();
                        },
                        child: const Text("Salvar"))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
