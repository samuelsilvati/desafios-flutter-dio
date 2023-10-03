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
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                maxLength: 8,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "Cep"),
                // controller: nomeUsuarioController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Logradouro"),
                // controller: nomeUsuarioController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Complemento"),
                // controller: nomeUsuarioController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Bairro"),
                // controller: nomeUsuarioController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Localidade"),
                // controller: nomeUsuarioController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                maxLength: 2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "UF"),
                // controller: nomeUsuarioController,
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
                  onPressed: () async {},
                  child: const Text(
                    "Cadastrar",
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
