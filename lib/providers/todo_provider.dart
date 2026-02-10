import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

enum TodoFilter { all, active, completed }

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];
  TodoFilter _filter = TodoFilter.all;

  List<Todo> get todos {
    switch (_filter) {
      case TodoFilter.active:
        return _todos.where((t) => !t.completed).toList();
      case TodoFilter.completed:
        return _todos.where((t) => t.completed).toList();
      case TodoFilter.all:
      default:
        return List<Todo>.from(_todos);
    }
  }

  TodoFilter get filter => _filter;

  void setFilter(TodoFilter f) {
    _filter = f;
    notifyListeners();
  }

  void addTodo(String title) {
    final t = Todo(id: UniqueKey().toString(), title: title);
    _todos.insert(0, t);
    _save();
    notifyListeners();
  }

  void toggleTodo(String id) {
    final idx = _todos.indexWhere((t) => t.id == id);
    if (idx != -1) {
      _todos[idx].completed = !_todos[idx].completed;
      _save();
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    _save();
    notifyListeners();
  }

  Todo? getById(String id) {
    try {
      return _todos.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateTodo(String id, {String? title, bool? completed}) {
    final idx = _todos.indexWhere((t) => t.id == id);
    if (idx != -1) {
      final t = _todos[idx];
      if (title != null) t.title = title;
      if (completed != null) t.completed = completed;
      _save();
      notifyListeners();
    }
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('todos');
    if (jsonStr != null) {
      final List<dynamic> jsonList = jsonDecode(jsonStr);
      _todos
        ..clear()
        ..addAll(jsonList.map((e) => Todo.fromJson(e)).toList());
    }
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _todos.map((t) => t.toJson()).toList();
    await prefs.setString('todos', jsonEncode(jsonList));
  }

  TodoProvider() {
    _load();
  }
}
