import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_application_1/app_todo/list_tasks/list_tasks_state.dart';
import 'package:flutter_application_1/app_todo/list_tasks/list_tasks_store.dart';
import 'package:flutter_application_1/app_todo/save_task/save_task_state.dart';
import 'package:flutter_application_1/app_todo/save_task/save_task_store.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
        title: const Text('CEP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<ListTasksStore>(builder: (context, store, child) {
              ListTasksState state = store.state;
              if (state is InitialListTasksState) {
                return const SizedBox(
                  height: 260,
                  child: Text('Sem historico'),
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
                            title: Text(state.tasks[index].description));
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
              controller: taskInputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tarefa',
              ),
            ),
            Consumer<SaveTaskStore>(
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
                  return Text(
                    state.description ?? 'Erro...',
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                }
                if (state is ExecutingSaveTaskState) {
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
