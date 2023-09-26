import 'package:flutter/material.dart';
// import 'package:meu_app_imc_2/pages/home_page.dart';
import 'package:meu_app_imc_2/pages/home_page_hive.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
        useMaterial3: true,
      ),
      home: const MyHomePageHive(),
    );
  }
}
