import 'dart:io';

import 'package:agenda/models/agenda_model.dart';
import 'package:agenda/repositories/agenda_repository.dart';
import 'package:agenda/screens/contact_details.dart';
import 'package:agenda/screens/create_contact.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AgendaBack4AppRepository agendaBack4AppRepository =
      AgendaBack4AppRepository();
  var _contacts = AgendaModel([]);
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  void loadContacts() async {
    setState(() {
      loading = true;
    });
    _contacts = await agendaBack4AppRepository.get();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Agenda"),
      ),
      body: loading
          ? const LinearProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: ListView.builder(
                itemCount: _contacts.results.length,
                itemBuilder: (BuildContext bc, index) {
                  var contact = _contacts.results[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: InkWell(
                      child: ListTile(
                        leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                image: contact.imagePath!.isNotEmpty
                                    ? DecorationImage(
                                        image: FileImage(
                                            File(contact.imagePath ?? '')),
                                        fit: BoxFit.cover)
                                    : null),
                            child: contact.imagePath!.isEmpty
                                ? Center(
                                    child: Text(
                                    contact.name[0],
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ))
                                : null),
                        title: Text(contact.name),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ContactDetailsPage(
                              contactDetail: contact,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )),
            ),
      floatingActionButton: !loading
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const CreateContactPage(),
                  ),
                );
              },
              tooltip: 'Adicionar Contato',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
