import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/cep/consultar/consultar_cep_state.dart';
import 'package:flutter_application_1/cep/consultar/consultar_cep_store.dart';

class CepHomePage extends StatelessWidget {
  const CepHomePage({super.key});

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
              'CEP 58043330:',
            ),
            Consumer<ConsultarCepStore>(
              builder: (context, store, child) {
                ConsultarCepState state = store.state;
                if (state is InitialConsultarCepState) {
                  return Text(
                    'Clique para consultar',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                if (state is LoadedConsultarCepState) {
                  return Column(
                    children: [
                      Text(
                        state.cep.logradouro,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        state.cep.bairro,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '${state.cep.localidade}/${state.cep.uf}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  );
                } else if (state is ErrorConsultarCepState) {
                  return Text(
                    state.description ?? 'Erro...',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state is LoadingConsultarCepState) {
                  return const CircularProgressIndicator(backgroundColor: Colors.black38);
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
            onPressed: () => context.read<ConsultarCepStore>().consultar('58043330'),
            tooltip: 'Consultar CEP',
            child: const Icon(Icons.find_in_page),
          ),
        ],
      ),
    );
  }

}