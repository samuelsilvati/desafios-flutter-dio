import 'package:agenda/screens/edit_contact.dart';
import 'package:agenda/screens/my_home_page.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({super.key});

  @override
  State<ContactDetailsPage> createState() => ContactDetailsPageState();
}

class ContactDetailsPageState extends State<ContactDetailsPage> {
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
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: const Icon(
                        Icons.warning,
                        size: 32,
                        color: Colors.redAccent,
                      ),
                      content: const Wrap(
                        children: [
                          Center(
                              child:
                                  Text("Deseja realmente apagar o contato?")),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar')),
                        TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage()),
                                  (route) => false);
                            },
                            child: const Text('Apagar'))
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Center(
                child: Text(
              "A",
              style: TextStyle(
                fontSize: 62,
                color: Theme.of(context).colorScheme.background,
              ),
            )),
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
