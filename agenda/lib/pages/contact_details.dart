import 'package:agenda/pages/edit_contact.dart';
import 'package:flutter/material.dart';

class ContactDetaielsPage extends StatefulWidget {
  const ContactDetaielsPage({super.key});

  @override
  State<ContactDetaielsPage> createState() => ContactDetaielsPageState();
}

class ContactDetaielsPageState extends State<ContactDetaielsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const EditContactPage(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Container(
            width: 120, // Defina o tamanho desejado para o botão
            height: 120, // Defina o tamanho desejado para o botão
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context)
                  .colorScheme
                  .inversePrimary, // Cor de fundo do botão
            ),
            child: Center(
              child: Icon(
                Icons.add_photo_alternate, // Ícone para adicionar uma imagem
                size: 40, // Tamanho do ícone
                color: Theme.of(context).colorScheme.background, // Cor do ícone
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
                child: Text(
              "Ana da Silva",
              style: TextStyle(fontSize: 20),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: "Telefone *"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: "E-mail"),
            ),
          ),
        ]),
      )),
    );
  }
}
