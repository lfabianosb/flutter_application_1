import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_application_1/cep/cep_home_page.dart';
import 'package:flutter_application_1/cep/consultar/consultar.dart';
import 'package:flutter_application_1/counter/counter_store.dart';
import 'package:flutter_application_1/service_locator.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CounterStore>(create: (_) => CounterStore()),
          ChangeNotifierProvider<ConsultarCepStore>(
              create: (_) => getIt.get<ConsultarCepStore>()),
        ],
        child: const CepHomePage(),
      ),
    );
  }
}
