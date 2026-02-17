// here we use "async"c keyword so that inside this function we can use the "await" keyword
void main() async{
	// we wait here until the fetchPost fetched the post data using the "await" keyword
	final Post post = await fetchPost();

	// then we display the post data
	print("Post title: ${post.title}");
	print("Author: ${post.userId}");
}

// fake api call
Future<Post> fetchPost(){
	final duration = Duration(seconds: 3);
	print("loading...");
	return(Future.delayed(duration, () { return  Post(title: "My Post", userId: 1); }));
}

// post model
class Post{
	String title;
	int userId;
	Post({required this.title, required this.userId});
}
