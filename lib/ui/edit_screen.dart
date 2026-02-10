import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class EditScreen extends StatelessWidget {
  final String todoId;
  const EditScreen({required this.todoId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todo = provider.getById(todoId);
    final titleController = TextEditingController(text: todo?.title ?? '');

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            Row(
              children: [
                Checkbox(
                  value: todo?.completed ?? false,
                  onChanged: (val) {
                    if (todo != null) provider.toggleTodo(todo.id);
                  },
                ),
                const Text('Completed'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (todo != null) {
                  provider.updateTodo(todo.id, title: titleController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
