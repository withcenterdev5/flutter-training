import 'package:counter/screens/a/a.screen.dart';
import 'package:counter/screens/b/b.screen.dart';
import 'package:counter/screens/c/c.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


// routing
final routes = GoRouter(
  routes: [
    GoRoute(path: '/', builder:(context, state) => const HomeScreen()),
    GoRoute(path: '/a', builder:(context, state) => const AScreen()),
    GoRoute(path: '/b', builder:(context, state) => const BScreen()),
    GoRoute(path: '/c', builder:(context, state) => const CScreen()),
  ]
);



void
main() {
  runApp(MaterialApp.router(routerConfig: routes,));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Using Go Router", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => context.push('/a'), child: Text("Go to A screen")),
            ElevatedButton(onPressed: () => context.push('/b'), child: Text("Go to B screen")),
            ElevatedButton(onPressed: () => context.push('/c'), child: Text("Go to C screen")),
          ],
        ),
      ),
    );
  }
}