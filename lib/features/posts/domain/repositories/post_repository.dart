import 'package:coachyp/features/posts/domain/entities/post.dart';

abstract class PostRepository {
  Future<void> createPost(Post post);
  Future<List<Post>> fetchPosts(); 
  Future<List<Post>> fetchPostsByType(String type);
  Future<void> likePost(String postId, String userId);

  // Optional Improvements:
Future<void> unlikePost(String postId, String userId);

  // Future<Either<Failure, List<Post>>> fetchPosts(); // 💬 if you implement error handling
}
