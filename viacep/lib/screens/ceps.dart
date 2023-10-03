import 'package:flutter/material.dart';
import 'package:viacep/screens/cadastrar_cep.dart';
import 'package:viacep/screens/cep_details.dart';

class CepsCadastrados extends StatefulWidget {
  const CepsCadastrados({super.key});

  @override
  State<CepsCadastrados> createState() => _CepsCadastradosState();
}

class _CepsCadastradosState extends State<CepsCadastrados> {
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
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext bc) => const CepView()));
                    },
                    child: const Row(
                      children: [
                        Text("35850-000"),
                      ],
                    )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext bc) => const CepView()));
                    },
                    child: const Row(
                      children: [
                        Text("35850-000"),
                      ],
                    )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    ));
  }
}
