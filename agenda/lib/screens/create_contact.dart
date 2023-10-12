import 'package:agenda/models/agenda_model.dart';
import 'package:agenda/repositories/agenda_repository.dart';
import 'package:agenda/screens/my_home_page.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({super.key});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  AgendaBack4AppRepository agendaBack4AppRepository =
      AgendaBack4AppRepository();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: const ListTile(
                            title: Text("Câmera"),
                            leading: Icon(Icons.camera),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: const ListTile(
                            title: Text("Galeria"),
                            leading: Icon(Icons.photo_library),
                          ),
                        )
                      ],
                    );
                  });
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Center(
                child: Icon(
                  Icons.add_photo_alternate,
                  size: 40,
                  color:
                      Theme.of(context).colorScheme.background, // Cor do ícone
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Center(child: Text("Adicionar imagem")),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              maxLength: 50,
              controller: nameController,
              decoration: const InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: "Nome Completo *"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              maxLength: 16,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter()
              ],
              keyboardType: TextInputType.number,
              controller: phoneController,
              decoration: const InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: "Telefone *"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              maxLength: 50,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: "E-mail"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.inversePrimary,
                    )),
                onPressed: () async {
                  await agendaBack4AppRepository.create(Results.create(
                      nameController.text,
                      phoneController.text,
                      '',
                      emailController.text));
                  if (!context.mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                      (route) => false);
                },
                child: const Text(
                  "Salvar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
