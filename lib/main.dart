import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PostProvider(PostService()),
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

// post model
class Post{
  final int id;
  final String title;
  final int userId;
  Post({required this.id, required this.title, required this.userId});

}

// post service
class PostService {
  Future<List<Post>> fetchPosts() async {
    // Simulate network latency
    await Future.delayed(const Duration(seconds: 2));
    
    return [
      Post(id: 1, title: "Building Scalable Flutter Apps", userId: 10),
      Post(id: 2, title: "The Power of Sealed Classes", userId: 10),
      Post(id: 3, title: "Why Shimmers beat Spinners", userId: 11),
      Post(id: 4, title: "Clean Architecture for Teams", userId: 12),
      Post(id: 5, title: "Advanced Bloc Techniques", userId: 12),
    ];
  }
}
// end of post service

// state management

sealed class PostState {}
class PostInitial extends PostState {}
class PostLoading extends PostState {}
class PostError extends PostState { final String message; PostError(this.message); }
class PostLoaded extends PostState { 
  final List<Post> posts; 
  PostLoaded(this.posts); 
}

class PostProvider extends ChangeNotifier {
  final PostService _service;
  PostProvider(this._service);

  PostState _state = PostInitial();
  PostState get state => _state;

  Future<void> loadPosts() async {
    _state = PostLoading();
    notifyListeners();
    try {
      final List<Post> results = await _service.fetchPosts();
      _state = PostLoaded(results);
    } catch (e) {
      _state = PostError("Could not load posts.");
    } finally {
      notifyListeners();
    }
  }
}
// end of state management

// UI
// Posts loading indicators
class PostShimmerList extends StatelessWidget {
  const PostShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6, // Show 6 skeleton items while loading
      itemBuilder: (context, index) => const PostShimmerItem(),
    );
  }
}
class PostShimmerItem extends StatelessWidget {
  const PostShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fake Leading Icon/Image
            Container(
              width: 48.0,
              height: 48.0,
              color: Colors.white,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fake Title line
                  Container(
                    width: double.infinity,
                    height: 14.0,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8.0),
                  // Fake Subtitle line (shorter)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 14.0,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Screens and Widgets
class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: () {
          // Handle navigation or selection here
          debugPrint('Tapped on: ${post.title}');
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Avatar (Matches Shimmer box)
              CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Text(
                  post.userId.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              // Post Content (Matches Shimmer lines)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "Post ID: ${post.id}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PostProvider>().state;

    return Scaffold(
      appBar: AppBar(title: const Text("My Blog")),
      body: RefreshIndicator(
        onRefresh: () => context.read<PostProvider>().loadPosts(),
        child: switch (state) {
          // posts initial state
          PostInitial() => ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7, // Centers the text visually
                  child: const Center(child: Text("Pull down to load posts")),
                ),
              ],
            ),
          // posts loading
          PostLoading() => const PostShimmerList(), 
          // posts error
          PostError(message: var m) => ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(child: Text(m)),
                ),
              ],
            ),
          // posts loaded
          PostLoaded(posts: var list) => ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(), 
              itemCount: list.length,
              itemBuilder: (context, index) {
                final post = list[index];
                return PostCard(post: post); 
              },
            ),
        },
      ),
    );
  }
}



