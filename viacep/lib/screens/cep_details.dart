import 'package:flutter/material.dart';
import 'package:viacep/screens/editar_cep.dart';

class CepView extends StatefulWidget {
  const CepView({super.key});

  @override
  State<CepView> createState() => _CepViewState();
}

class _CepViewState extends State<CepView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cep"),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext bc) => const EditarCep()));
          }),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Cep: 35850"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Logradouro: A"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Complemento: "),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Bairro: "),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Localidade: Congonahas do Norte"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("UF: MG"),
            ),
          ],
        ),
      ),
    ));
  }
}
