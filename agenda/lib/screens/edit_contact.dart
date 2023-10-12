import 'package:agenda/models/agenda_model.dart';
import 'package:agenda/repositories/agenda_repository.dart';
import 'package:agenda/screens/my_home_page.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditContactPage extends StatefulWidget {
  final Results contactDetail;
  const EditContactPage({super.key, required this.contactDetail});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  AgendaBack4AppRepository agendaBack4AppRepository =
      AgendaBack4AppRepository();
  String contactId = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    contactId = widget.contactDetail.objectId;
    nameController.text = widget.contactDetail.name;
    phoneController.text = widget.contactDetail.phoneNumber;
    emailController.text = widget.contactDetail.email ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Editar contato'),
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
              width: 100, // Defina o tamanho desejado para o botão
              height: 100, // Defina o tamanho desejado para o botão
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
              decoration: const InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: "Nome Completo *"),
              controller: nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter()
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: "Telefone *"),
              controller: phoneController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                  labelText: "E-mail"),
              controller: emailController,
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
                  await agendaBack4AppRepository.edit(Results.update(
                      contactId,
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
