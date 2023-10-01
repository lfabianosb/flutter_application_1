import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/counter_store.dart';
import 'package:flutter_application_1/counter_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer<CounterStore>(
              builder: (context, store, child) {
                CounterState state = store.state;
                if (state is SuccessCounterState) {
                  return Text(
                    '${state.value}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state is ErrorCounterState) {
                  return Text(
                    state.description ?? 'Erro...',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state is LoadingCounterState) {
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
            onPressed: context.read<CounterStore>().decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: context.read<CounterStore>().increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

}