import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// define your app strings here
const String appName = "TODO";

// define your app colors here
const Color primary = Colors.deepPurpleAccent;
const Color secondary = Color.fromARGB(255, 87, 87, 134);

const Color bgLight = Color.fromARGB(255, 240, 200, 247);


// define your font sizes here
const double todoTitle = 25.0;  

void main(){
  runApp(ChangeNotifierProvider(
    create: (context) => TodoProvider(),
    child: MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: primary)),
      title: appName,
      home: Home(),
    ),
  ));
}


class Todo {
  final String title;
  bool isDone;
  Todo({required this.title, this.isDone = false});
}

class TodoProvider extends ChangeNotifier {
   List<Todo> tasks = [
    Todo(title: "Learn Flutter"),
    Todo(title: "Implement Consumers"),
  ];

  List<Todo> get getTasks => tasks;

  void toggleTask(int index) {
    tasks[index].isDone = !tasks[index].isDone;
    // This is crucial! Without this, Consumer won't know to rebuild.
    notifyListeners(); 
  }

   void addTodo(String newTitle) {
    if (newTitle.isNotEmpty) {
      tasks.add(Todo(title: newTitle));
      notifyListeners(); // 📣 Essential for the UI to see the new item!
    }
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController textEditingController = .new();

  void addTodo(String newTitle){
    context.read<TodoProvider>().addTodo(newTitle);
  }


  void _showAddTodoDialog() {
  // Clear the text controller so it's empty for the new entry
  textEditingController.clear();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: textEditingController,
          autofocus: true,
          decoration: const InputDecoration(hintText: "What needs to be done?"),
          // Allows the user to press "Enter" on the keyboard to save
          onSubmitted: (value) {
            addTodo(value);
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              addTodo(textEditingController.text);
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

  @override
  void dispose(){
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: TodoList()
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => _showAddTodoDialog(), child: Icon(Icons.add)),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        // Use ListView.builder for better performance with long lists
        return ListView.builder(
          shrinkWrap: true, // Needed if inside a Padding/Column
          itemCount: provider.tasks.length,
          itemBuilder: (context, index) {
            final todo = provider.tasks[index];
            return TodoItem(todo: todo, index: index);
          },
        );
      },
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final int index;

  const TodoItem({super.key, required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: bgLight,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              todo.title,
              style: TextStyle(
                fontSize: todoTitle,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          Checkbox(
            value: todo.isDone,
            onChanged: (val) {
              // We use .read here because it's a one-time action
              context.read<TodoProvider>().toggleTask(index);
            },
          )
        ],
      ),
    );
  }
}