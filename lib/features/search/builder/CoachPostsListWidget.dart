import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coachyp/colors.dart';

class CoachPostsListWidget extends StatelessWidget {
  final String coachId;

  const CoachPostsListWidget({Key? key, required this.coachId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('coachId', isEqualTo: coachId)
          .where('isActive', isEqualTo: true)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        print('📦 New snapshot received for coachId: $coachId');
        
        if (snapshot.hasError) {
          print('❌ Snapshot error: ${snapshot.error}');
          return const Center(
            child: Text('Error loading posts', style: TextStyle(color: Colors.black)),
          );
        }

        if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
          print('⏳ Waiting for snapshot...');
          return const Center(child: CircularProgressIndicator());
        }

        final posts = snapshot.data!.docs;
        print('✅ Posts fetched: ${posts.length}');

        if (posts.isEmpty) {
          print('⚡ No posts found');
          return const Center(
            child: Text('No posts available', style: TextStyle(color: Colors.black)),
          );
        }

        return SizedBox(
          height: 400, // Fixed height ✅ to prevent disappearing
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index].data() as Map<String, dynamic>;
              print('🖼️ Post ${index + 1}: ${post['description']}');

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (post['imageUrl'] != null && post['imageUrl'].isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            post['imageUrl'],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 50),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          post['description'] ?? '',
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
