import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';
import 'package:go_router/go_router.dart';
import 'edit_screen.dart';
import 'add_todo_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todos;

    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: Column(
        children: [
          // Filter chips
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _FilterChip(
                  label: 'All',
                  selected: provider.filter == TodoFilter.all,
                  onSelected: () => provider.setFilter(TodoFilter.all),
                ),
                _FilterChip(
                  label: 'Active',
                  selected: provider.filter == TodoFilter.active,
                  onSelected: () => provider.setFilter(TodoFilter.active),
                ),
                _FilterChip(
                  label: 'Completed',
                  selected: provider.filter == TodoFilter.completed,
                  onSelected: () => provider.setFilter(TodoFilter.completed),
                ),
              ],
            ),
          ),
          // List
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (ctx, i) {
                final t = todos[i];
                return ListTile(
                  leading: Checkbox(
                    value: t.completed,
                    onChanged: (_) => provider.toggleTodo(t.id),
                  ),
                  title: Text(
                    t.title,
                    style: TextStyle(
                      decoration: t.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  onTap: () => GoRouter.of(context).go('/edit/${t.id}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => provider.deleteTodo(t.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showDialog(context: context, builder: (_) => const AddTodoDialog()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
    );
  }
}
