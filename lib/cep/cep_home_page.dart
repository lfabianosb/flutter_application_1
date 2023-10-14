import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_application_1/cep/consultar/consultar.dart';
import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';

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
            Consumer<ConsultarHistoricoCepStore>(
                builder: (context, store, child) {
              ConsultarHistoricoCepState state = store.state;
              if (state is InitialConsultarHistoricoCepState) {
                return const SizedBox(
                  height: 260,
                  child: Text('Sem historico'),
                );
              }
              if (state is LoadingConsultarHistoricoCepState) {
                return const CircularProgressIndicator(
                    backgroundColor: Colors.black38);
              }
              if (state is ErrorConsultarHistoricoCepState) {
                return Text(
                  state.description ?? 'Erro...',
                  style: Theme.of(context).textTheme.headlineSmall,
                );
              }
              if (state is LoadedConsultarHistoricoCepState) {
                return SizedBox(
                  height: 260,
                  child: ListView.builder(
                      itemCount: state.ceps.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(state.ceps[index].cep));
                      }),
                );
              }
              return const Text('');
            }),
            const SizedBox(height: 80),
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
                }
                if (state is ErrorConsultarCepState) {
                  return Text(
                    state.description ?? 'Erro...',
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                }
                if (state is LoadingConsultarCepState) {
                  return const CircularProgressIndicator(
                      backgroundColor: Colors.black38);
                }
                return const Text('');
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
          FloatingActionButton(
            onPressed: () =>
                context.read<ConsultarHistoricoCepStore>().consultar(),
            tooltip: 'Historico de CEPs',
            child: const Icon(Icons.history_rounded),
          ),
        ],
      ),
    );
  }
}
