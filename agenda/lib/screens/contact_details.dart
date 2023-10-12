import 'package:agenda/models/agenda_model.dart';
import 'package:agenda/repositories/agenda_repository.dart';
import 'package:agenda/screens/edit_contact.dart';
import 'package:agenda/screens/my_home_page.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  final Results contactDetail;
  const ContactDetailsPage({super.key, required this.contactDetail});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  AgendaBack4AppRepository agendaBack4AppRepository =
      AgendaBack4AppRepository();
  @override
  Widget build(BuildContext context) {
    var contact = widget.contactDetail;
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
                            onPressed: () async {
                              await agendaBack4AppRepository
                                  .delete(contact.objectId);
                              if (!context.mounted) return;
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ListView(children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.inversePrimary,
                image: contact.imagePath.isNotEmpty
                    ? const DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"),
                        fit: BoxFit.cover)
                    : null),
            child: contact.imagePath.isEmpty
                ? Center(
                    child: Text(
                    contact.name[0],
                    style: TextStyle(
                      fontSize: 62,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ))
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
                child: Text(
              contact.name,
              style: const TextStyle(fontSize: 20),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Informaçoes de contato',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(
                        width: 10,
                      ),
                      SelectableText(contact.phoneNumber),
                    ],
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: contact.email.isNotEmpty
                  ? Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.mail),
                            const SizedBox(
                              width: 10,
                            ),
                            SelectableText(contact.email),
                          ],
                        ),
                      ),
                    )
                  : null),
        ]),
      )),
    );
  }
}
