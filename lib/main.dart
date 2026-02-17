import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostScreen()
    );
  }
}


// fake api call
Future<Post> fetchPost() {
  final duration = Duration(seconds: 3);
  return Future.delayed(duration, (){
    return Post(title: "My Post", userId: 2);
  });
}
// post model
class Post{
  final String title;
  final int userId;
  Post({required this.title, required this.userId});

}


// post provider for logic
class PostProvider extends ChangeNotifier {
  Post? _post;
  bool _isLoading = false;
  String? _error;

  // Getters to expose state safely to the UI
  Post? get post => _post;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPost() async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // Tell UI to show the spinner

    try {
      _post = await fetchPost(); 
    } catch (e) {
      _error = "Failed to load post. Please try again.";
    } finally {
      _isLoading = false;
      notifyListeners(); // Tell UI to show the data or error
    }
  }
}


class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Async Provider")),
      body: Center(
        child: Consumer<PostProvider>(
          builder: (context, provider, child) {
            // 1. Loading State
            if (provider.isLoading) {
              return const CircularProgressIndicator();
            }

            // 2. Error State
            if (provider.error != null) {
              return Text(provider.error!, style: const TextStyle(color: Colors.red));
            }

            // 3. Empty State
            if (provider.post == null) {
              return const Text("Press the button to fetch a post.");
            }

            // 4. Success State
            return Column(
              mainAxisAlignment: .center,
              children: [
                Text(provider.post!.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("User: ${provider.post!.userId}"),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PostProvider>().loadPost(),
        child: const Icon(Icons.cloud_download),
      ),
    );
  }
}



