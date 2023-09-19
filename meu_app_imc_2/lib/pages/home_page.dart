import 'package:flutter/material.dart';
import 'package:meu_app_imc_2/models/imc.dart';
import 'package:meu_app_imc_2/repository/imc_repository.dart';
import 'package:meu_app_imc_2/service/calcula_resultado_final.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var altura = TextEditingController();
  var peso = TextEditingController();

  var imcRepository = IMCRepository();
  var _resultadoFinal = const <IMC>[];

  void calculaIMC() {
    final novaAltura = altura.text.replaceAll(',', '.');
    double alturaDouble = double.parse(novaAltura);
    double pesoDouble = double.parse(peso.text);

    String resultadoImc = calculaResultadoFinal(pesoDouble, alturaDouble);

    imcRepository.adicionar(alturaDouble, pesoDouble, resultadoImc);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _resultadoFinal = imcRepository.listaResultados();
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
                  child: Text(
                      "Clique no botão abaixo para adicionar um calculo de imc"),
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
                      "Peso ${imcData.peso} Kg | Altura ${imcData.altura}"),
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
                                  Text("Deseja realmente apagar o calculo?"),
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
                                      imcRepository.remover(imcData.id);
                                      Navigator.pop(context);
                                      setState(() {});
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
                          // await tarefaRepository.adicionar(
                          //     Tarefa(descricaoController.text, false));
                          setState(() {});
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
