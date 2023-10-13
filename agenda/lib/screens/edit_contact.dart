import 'dart:io';

import 'package:agenda/models/agenda_model.dart';
import 'package:agenda/repositories/agenda_repository.dart';
import 'package:agenda/screens/my_home_page.dart';
import 'package:agenda/widgets/flutter_toast.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class EditContactPage extends StatefulWidget {
  final Results contactDetail;
  final Image? img;
  const EditContactPage({super.key, required this.contactDetail, this.img});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  AgendaBack4AppRepository agendaBack4AppRepository =
      AgendaBack4AppRepository();
  String contactId = '';
  String name = '';
  String phone = '';
  String email = '';
  String imagePath = '';
  bool loading = false;
  var toast = FlutterToast();
  final ImagePicker picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    contactId = widget.contactDetail.objectId;
    name = widget.contactDetail.name;
    phone = widget.contactDetail.phoneNumber;
    email = widget.contactDetail.email!;
    imagePath = widget.contactDetail.imagePath!;
  }

  @override
  Widget build(BuildContext context) {
    Image? image = widget.img;
    cropImage(XFile imageFile) async {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Theme.of(context).colorScheme.inversePrimary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      imagePath = croppedFile!.path;
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: Center(
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

                              final XFile? photo = await picker.pickImage(
                                  source: ImageSource.camera);
                              if (photo != null) {
                                await ImageGallerySaver.saveFile(photo.path);
                                cropImage(photo);
                              }
                            },
                            child: const ListTile(
                              title: Text("Câmera"),
                              leading: Icon(Icons.camera),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.pop(context);

                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                cropImage(image);
                              }
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
                      image: image != null
                          ? DecorationImage(
                              image: FileImage(File(imagePath)),
                              fit: BoxFit.contain)
                          : null),
                  child: image == null
                      ? Center(
                          child: Icon(
                            Icons.add_photo_alternate,
                            size: 40,
                            color: Theme.of(context)
                                .colorScheme
                                .background, // Cor do ícone
                          ),
                        )
                      : null),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                  child: image == null
                      ? const Text("Adicionar imagem")
                      : const Text("Trocar imagem")),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                initialValue: name,
                maxLength: 50,
                decoration: const InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "Nome Completo *"),
                validator: (name) {
                  if (name!.trim().isEmpty) {
                    return 'Por favor, insira um nome.';
                  } else if (name.length < 3) {
                    return 'O nome precisa ter pelo menos três caracteres';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                initialValue: phone,
                maxLength: 16,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "Telefone *"),
                validator: (phone) {
                  if (phone!.isEmpty) {
                    return 'Por favor, insira um número de telefone.';
                  } else if (phone.length < 15) {
                    return 'O telefone está incompleto.';
                  }
                  return null;
                },
                onSaved: (value) {
                  phone = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                initialValue: email,
                maxLength: 50,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(),
                    labelText: "E-mail"),
                onSaved: (value) {
                  email = value!;
                },
              ),
            ),
            !loading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.inversePrimary,
                            )),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              loading = true;
                            });
                            try {
                              await agendaBack4AppRepository.edit(
                                  Results.update(contactId, name, phone,
                                      imagePath, email));
                            } catch (e) {
                              toast.error("Não foi possível salvar o contato.");
                            }
                          } else {
                            return;
                          }
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
                  )
                : const Center(
                    child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  )),
          ]),
        )),
      ),
    );
  }
}
