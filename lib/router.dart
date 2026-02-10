import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/todo_provider.dart';
import 'ui/home_screen.dart';
import 'ui/edit_screen.dart';

GoRouter router(BuildContext context) {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/edit/:id',
        builder: (context, state) {
          final id = state.params['id']!;
          return EditScreen(todoId: id);
        },
      ),
    ],
  );
}
