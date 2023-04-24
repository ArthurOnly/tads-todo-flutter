import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_todo/src/tasks/data/tasks_repo.dart';
import 'package:simple_todo/src/tasks/db/virtual_db.dart';
import 'package:simple_todo/src/tasks/domain/task.dart';
import 'package:simple_todo/src/tasks/presentation/tasks_show_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple TODO')),
      body: const TaskListComponent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // índice da aba ativa, começa em 0
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Criar tarefa',
          ),
        ],
        onTap: (index) {
          Navigator.pushNamed(context, index == 0 ? '/tasks' : '/tasks/create');
        },
      ),
    );
  }
}

class TaskListComponent extends StatefulWidget {
  const TaskListComponent({Key? key}) : super(key: key);

  @override
  State<TaskListComponent> createState() => _TaskListComponentState();
}

class _TaskListComponentState extends State<TaskListComponent> {
  late List<Task> taskList = [];
  TaskRepository taskRepo = TaskRepository(taskDB);

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  void updateTaskList() {
    getTasks();
  }

  void getTasks() async {
    List<Task> tasks = await taskRepo.getAll();
    setState(() {
      taskList = tasks;
    });
  }

  void showTask() {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: taskList
          .map((todo) => TaskItemComponent(
                id: todo.id,
                title: todo.title,
                description: todo.description,
                onTaskDeleted: updateTaskList,
              ))
          .toList(),
    );
  }
}

class TaskItemComponent extends StatelessWidget {
  final String title;
  final String description;
  final int id;
  final TaskRepository taskRepo = TaskRepository(taskDB);
  final VoidCallback? onTaskDeleted;

  TaskItemComponent(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      this.onTaskDeleted});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Wrap(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskShowScreen(taskId: id),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                taskRepo.delete(id);
                if (onTaskDeleted != null) {
                  onTaskDeleted!();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
