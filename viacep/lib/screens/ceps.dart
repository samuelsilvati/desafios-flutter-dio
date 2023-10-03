import 'package:flutter/material.dart';
import 'package:viacep/models/cadastro_cep.dart';
import 'package:viacep/repositories/cep_back4app_repository.dart';
import 'package:viacep/screens/cadastrar_cep.dart';
import 'package:viacep/screens/cep_details.dart';
import 'package:viacep/screens/editar_cep.dart';

class CepsCadastrados extends StatefulWidget {
  const CepsCadastrados({super.key});

  @override
  State<CepsCadastrados> createState() => _CepsCadastradosState();
}

class _CepsCadastradosState extends State<CepsCadastrados> {
  CepBack4AppRepository cepBack4AppRepository = CepBack4AppRepository();
  var _ceps = CadastroCepModel([]);
  var loading = false;
  @override
  void initState() {
    loadCeps();
    super.initState();
  }

  void loadCeps() async {
    setState(() {
      loading = true;
    });
    _ceps = await cepBack4AppRepository.get();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ceps Cadastrados"),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext bc) => const CadastrarCep()));
          }),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: loading
            ? const Center(heightFactor: 2, child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _ceps.results.length,
                itemBuilder: (BuildContext bc, int index) {
                  var cep = _ceps.results[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext bc) =>
                                            CardDetailPage(
                                              cepDetail: cep,
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(cep.cep),
                                  ],
                                ),
                              )),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            title: const Icon(
                                              Icons.warning,
                                              size: 32,
                                              color: Colors.redAccent,
                                            ),
                                            content: const Text(
                                              "Deseja realmente Apagar o Cep?",
                                              textAlign: TextAlign.center,
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Não')),
                                              TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    await cepBack4AppRepository
                                                        .delete(cep.objectId);
                                                    loadCeps();
                                                  },
                                                  child: const Text('Sim'))
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext bc) =>
                                                EditarCep(
                                                  cepDetail: cep,
                                                )));
                                  },
                                  icon: const Icon(Icons.edit)),
                            ],
                          )
                        ],
                      ),
                      const Divider()
                    ],
                  );
                }),
      ),
    ));
  }
}
