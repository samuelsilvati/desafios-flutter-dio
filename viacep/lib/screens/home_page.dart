import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viacep/models/viacep_model.dart';
import 'package:viacep/repositories/viacep_repository.dart';
import 'package:viacep/screens/cadastrar_cep.dart';
import 'package:viacep/screens/ceps.dart';
import 'package:viacep/shared/widgets/flutter_toast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var cepController = TextEditingController(text: "");
  String endereco = "";
  String cidade = "";
  String estado = "";
  bool loading = false;
  var viacepModel = ViacepModel();
  var viacepRepository = ViaCepRepository();
  var toast = FlutterToast();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Consulta CEP"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (menu) {},
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext bc) =>
                                  const CepsCadastrados()));
                    },
                    value: "opcao1",
                    child: const Text("Ceps Cadastrados")),
              ];
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 18),
              child: Icon(
                Icons.mail_outline_outlined,
                size: 40,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 9),
              child: Text(
                'Consultar CEP',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: TextField(
                maxLength: 8,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "Cep"),
                controller: cepController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    setState(() {
                      loading = true;
                    });
                    if (cepController.text.length == 8) {
                      try {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        endereco = "";
                        cidade = "";
                        estado = "";
                        viacepModel = await viacepRepository
                            .consultarCEP(cepController.text);

                        endereco = viacepModel.logradouro ?? "";
                        cidade = viacepModel.localidade ?? "";
                        estado = viacepModel.uf ?? "";
                        setState(() {
                          loading = false;
                        });
                        if (cidade == "") {
                          toast.warning(
                              "O Cep buscado não existe. Faça o cadastro");
                          if (mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext bc) =>
                                        const CadastrarCep()));
                          }
                        }
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                        cepController.text = "";
                        endereco = "";
                        cidade = "";
                        estado = "";
                        toast.error("Cep Inválido");
                      }
                    } else {
                      endereco = "";
                      cidade = "";
                      estado = "";
                      setState(() {
                        loading = false;
                      });
                      toast.error("Cep Incompleto");
                    }
                  },
                  child: const Text(
                    "Buscar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Visibility(
              visible: cidade != "",
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        endereco,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$cidade - $estado',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: loading, child: const CircularProgressIndicator())
          ],
        ),
      ),
      // ),
    ));
  }
}
