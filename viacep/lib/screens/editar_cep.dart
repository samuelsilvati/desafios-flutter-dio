import 'package:flutter/material.dart';
import 'package:viacep/models/cadastro_cep.dart';
import 'package:viacep/repositories/cep_back4app_repository.dart';
import 'package:viacep/shared/widgets/flutter_toast.dart';
// import 'package:viacep/screens/ceps.dart';

class EditarCep extends StatefulWidget {
  final Results cepDetail;
  const EditarCep({super.key, required this.cepDetail});

  @override
  State<EditarCep> createState() => _CadastrarCepState();
}

class _CadastrarCepState extends State<EditarCep> {
  CepBack4AppRepository cepBack4AppRepository = CepBack4AppRepository();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController logradouroController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController localidadeController = TextEditingController();
  final TextEditingController ufController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cepController.text = widget.cepDetail.cep;
    logradouroController.text = widget.cepDetail.logradouro;
    complementoController.text = widget.cepDetail.complemento;
    bairroController.text = widget.cepDetail.bairro;
    localidadeController.text = widget.cepDetail.localidade;
    ufController.text = widget.cepDetail.uf;
  }

  @override
  Widget build(BuildContext context) {
    var objectId = widget.cepDetail.objectId;
    var toast = FlutterToast();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Editar"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                maxLength: 8,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "Cep *"),
                controller: cepController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Logradouro"),
                controller: logradouroController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Complemento"),
                controller: complementoController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Bairro"),
                controller: bairroController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Localidade *"),
                controller: localidadeController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                maxLength: 2,
                decoration: const InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "UF *"),
                controller: ufController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.inversePrimary,
                      )),
                  onPressed: () async {
                    try {
                      await cepBack4AppRepository.edit(Results.update(
                          objectId,
                          cepController.text,
                          logradouroController.text,
                          complementoController.text,
                          bairroController.text,
                          localidadeController.text,
                          ufController.text));

                      toast.success("Cep Editado");
                    } catch (e) {
                      toast.error("Erro ao editar cep");
                    }
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
