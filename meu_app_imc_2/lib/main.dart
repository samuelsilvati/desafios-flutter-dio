import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meu_app_imc_2/models/imc_hive_model.dart';
import 'package:meu_app_imc_2/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(IMCHiveModelAdapter());
  runApp(const MyApp());
}
