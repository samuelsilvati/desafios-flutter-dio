import 'package:flutter/material.dart';

class CadastrarCep extends StatefulWidget {
  const CadastrarCep({super.key});

  @override
  State<CadastrarCep> createState() => _CadastrarCepState();
}

class _CadastrarCepState extends State<CadastrarCep> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cadastrar Cep"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    Text("35850-000"),
                  ],
                )),
            const Divider(),
          ],
        ),
      ),
    ));
  }
}
