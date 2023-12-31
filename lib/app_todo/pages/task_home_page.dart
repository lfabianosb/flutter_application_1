import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_application_1/app_todo/application/list_tasks/list_tasks_state.dart';
import 'package:flutter_application_1/app_todo/application/list_tasks/list_tasks_store.dart';
import 'package:flutter_application_1/app_todo/application/save_task/save_task_state.dart';
import 'package:flutter_application_1/app_todo/application/save_task/save_task_store.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final taskInputController = TextEditingController();

  @override
  void dispose() {
    taskInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ListTaskWidget(),
              const SizedBox(height: 80),
              const Text(
                'Tarefa:',
              ),
              TextField(
                controller: taskInputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tarefa',
                ),
              ),
              const SaveTaskWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<SaveTaskStore>().execute(taskInputController.text);
            },
            tooltip: 'Salvar',
            child: const Icon(Icons.save_rounded),
          ),
        ],
      ),
    );
  }
}

class SaveTaskWidget extends StatelessWidget {
  const SaveTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SaveTaskStore>(
      builder: (context, store, child) {
        SaveTaskState state = store.state;
        if (state is InitialSaveTaskState) {
          return const Text('');
        }
        if (state is ExecutedSaveTaskState) {
          return Column(
            children: [
              Text(
                '${state.task.description} saved',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          );
        }
        if (state is ErrorSaveTaskState) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: Text(state.description ?? 'Erro desconhecido'),
                    ),
                  ));
          return const Text('');
        }
        if (state is ExecutingSaveTaskState) {
          return const CircularProgressIndicator(
              backgroundColor: Colors.black38);
        }
        return const Text('');
      },
    );
  }
}

class ListTaskWidget extends StatelessWidget {
  const ListTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListTasksStore>(
      builder: (context, store, child) {
        ListTasksState state = store.state;
        if (state is InitialListTasksState) {
          return const SizedBox(
            height: 260,
            child: Text('Sem tarefas'),
          );
        }
        if (state is ExecutingListTasksState) {
          return const CircularProgressIndicator(
              backgroundColor: Colors.black38);
        }
        if (state is ErrorListTasksState) {
          return Text(
            state.description ?? 'Erro...',
            style: Theme.of(context).textTheme.headlineSmall,
          );
        }
        if (state is ExecutedListTasksState) {
          return SizedBox(
            height: 260,
            child: ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${state.tasks[index].description} - (${state.tasks[index].id.value})'),
                );
              },
            ),
          );
        }
        return const Text('');
      },
    );
  }
}
