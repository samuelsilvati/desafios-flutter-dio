import 'package:flutter/material.dart';
import 'package:viacep/models/cadastro_cep.dart';

class CardDetailPage extends StatelessWidget {
  final Results cepDetail;
  const CardDetailPage({super.key, required this.cepDetail});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cepDetail.objectId,
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                  ],
                ),
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Cep: ${cepDetail.cep}"),
                          Text("Logradouro: ${cepDetail.logradouro}"),
                          Text("Complemento: ${cepDetail.complemento}"),
                          Text("Bairro: ${cepDetail.bairro}"),
                          Text("Localidade: ${cepDetail.localidade}"),
                          Text("UF: ${cepDetail.uf}"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
