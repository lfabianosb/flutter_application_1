import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_application_1/cep/consultar/consultar.dart';

class CepHomePage extends StatefulWidget {
  const CepHomePage({super.key});

  @override
  State<CepHomePage> createState() => _CepHomePageState();
}

class _CepHomePageState extends State<CepHomePage> {
  final cepInputController = TextEditingController();

  @override
  void dispose() {
    cepInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CEP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'CEP:',
            ),
            TextField(
              controller: cepInputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a CEP',
              ),
            ),
            Consumer<ConsultarCepStore>(
              builder: (context, store, child) {
                ConsultarCepState state = store.state;
                if (state is InitialConsultarCepState) {
                  return const Text('');
                }
                if (state is LoadedConsultarCepState) {
                  return Column(
                    children: [
                      Text(
                        state.cep.logradouro,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        state.cep.bairro,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${state.cep.localidade}/${state.cep.uf}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  );
                } else if (state is ErrorConsultarCepState) {
                  return Text(
                    state.description ?? 'Erro...',
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                } else if (state is LoadingConsultarCepState) {
                  return const CircularProgressIndicator(
                      backgroundColor: Colors.black38);
                } else {
                  return Text(
                    'Sem valor',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => context
                .read<ConsultarCepStore>()
                .consultar(cepInputController.text),
            tooltip: 'Consultar CEP',
            child: const Icon(Icons.find_in_page),
          ),
        ],
      ),
    );
  }
}
