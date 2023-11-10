import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/todo/stream/application/list_all_tasks/list_all_tasks_cubit.dart';
import 'package:flutter_application_1/todo/stream/application/list_all_tasks/list_all_tasks_state.dart';
import 'package:flutter_application_1/todo/stream/application/save_task/save_task_cubit.dart';
import 'package:flutter_application_1/todo/stream/application/save_task/save_task_state.dart';

class BlocStreamTaskHomePage extends StatefulWidget {
  const BlocStreamTaskHomePage({super.key});

  @override
  State<BlocStreamTaskHomePage> createState() => _BlocStreamTaskHomePageState();
}

class _BlocStreamTaskHomePageState extends State<BlocStreamTaskHomePage> {
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
        title: const Text('Todo Stream'),
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
              context.read<SaveTaskCubit>().execute(taskInputController.text);
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
    return BlocConsumer<SaveTaskCubit, SaveTaskState>(
      listener: (context, state) {
        if (state is ErrorSaveTaskState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(state.description ?? 'Erro desconhecido'),
            ),
          );
        }
      },
      builder: (context, state) {
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
    return BlocConsumer<ListAllTasksCubit, ListAllTasksState>(
      listener: (context, state) {
        if (state is ErrorListAllTasksState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.description ?? 'Erro...')));
        }
      },
      builder: (_, state) {
        if (state is InitialListAllTasksState) {
          return const SizedBox(
            height: 260,
            child: Text('Sem tarefas'),
          );
        }
        if (state is ExecutingListAllTasksState) {
          return const CircularProgressIndicator(
              backgroundColor: Colors.black38);
        }
        if (state is ExecutedListAllTasksState) {
          return SizedBox(
            height: 260,
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
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
