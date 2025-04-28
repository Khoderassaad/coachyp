import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachyp/colors.dart';
import 'package:coachyp/features/chat/data/search_user_page.dart';
import 'package:coachyp/features/court/presentation/pages/court.dart';
import 'package:coachyp/features/posts/domain/entities/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CoachHomePage extends StatefulWidget {
  const CoachHomePage({super.key});

  @override
  State<CoachHomePage> createState() => _CoachHomePageState();
}

class _CoachHomePageState extends State<CoachHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Post> posts = []; // List to store posts

  @override
  void initState() {
    super.initState();
    _fetchUserPosts();
  }

  // Fetch user's posts from Firestore
  Future<void> _fetchUserPosts() async {
  try {
    final user = _auth.currentUser;
    if (user == null) {
      print("No user is logged in.");
      return; // Exit early if the user is not logged in
    }

    final userId = user.uid;
    print("Fetching posts for user ID: $userId");

    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('coachId', isEqualTo: userId)
        .get();

    // Check if posts are fetched
    print("Fetched posts count: ${querySnapshot.docs.length}");

    final fetchedPosts = querySnapshot.docs.map((doc) {
      final data = doc.data();

      // Safely handle possible null for availableDates
      final availableDatesData = data['availableDates'] ?? {};  // Default to an empty map if null

      // Ensure availableDates is a Map<String, List<String>>
      final availableDates = Map<String, List<String>>.from(
        availableDatesData.map((key, value) => MapEntry(key, List<String>.from(value))),
      );

      return Post(
        id: doc.id,
        coachId: data['coachId'],
        description: data['description'],
        imageUrl: data['imageUrl'] ?? '',
        timestamp: data['timestamp'].toDate(),
        availableDates: availableDates,
        username: data['username'] ?? '',
        type: data['type'] ?? '',
        profileImgUrl: data['profileImgUrl'] ?? '', likes: [],
      );
    }).toList();

    setState(() {
      posts = fetchedPosts;
    });
  } catch (e) {
    print("Error fetching posts: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: ShaderMask(
          shaderCallback: (bounds) => myLinearGradient().createShader(bounds),
          child: const Text(
            "COACHY",
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 36,
              fontFamily: 'Jersey15',
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(LineIcons.cog),
            onPressed: () {
              // Add settings functionality here
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: const Icon(LineIcons.facebookMessenger),
              onPressed: () {
                // Navigate to the search screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchUserPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Subscription Button
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Subscription Page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.s2,
                  textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Subscription', style: TextStyle(color: AppColors.primary)),
              ),
            ),
            const SizedBox(height: 30),

            // My Posts Button
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to My Posts Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyPostsPage(posts: posts),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.s2,
                  textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('My Posts', style: TextStyle(color: AppColors.primary)),
              ),
            ),
            const SizedBox(height: 30),

            // Nearby Court Button
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Nearby Court
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SportCourtFinder()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.s2,
                  textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Nearby Court', style: TextStyle(color: AppColors.primary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPostsPage extends StatelessWidget {
  final List<Post> posts;
  const MyPostsPage({super.key, required this.posts});

  // Function to handle post deletion by setting isActive to false
  Future<void> _deletePost(String postId) async {
    try {
      final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
      await postRef.update({
        'isActive': false,  // Mark post as inactive
      });
      print("Post with ID $postId marked as inactive.");
    } catch (e) {
      print("Error deleting post: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter out posts where isActive is false
    final activePosts = posts.where((post) => post.isActive).toList();

    // Debugging output
    print("Number of active posts to display: ${activePosts.length}");

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Posts'),
        backgroundColor: AppColors.primary,
      ),
      body: activePosts.isEmpty
          ? const Center(child: Text('No active posts available'))
          : ListView.builder(
              itemCount: activePosts.length,
              itemBuilder: (context, index) {
                final post = activePosts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              post.username,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            // Popup menu with delete option
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'delete') {
                                  _deletePost(post.id); // Call delete post function
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete Post'),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(post.description),
                        const SizedBox(height: 10),
                        Text('Available Dates:'),
                        for (var entry in post.availableDates.entries)
                          Text('${entry.key}: ${entry.value.join(', ')}'),
                        const SizedBox(height: 10),
                        post.imageUrl.isNotEmpty
                            ? Image.network(post.imageUrl)
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

