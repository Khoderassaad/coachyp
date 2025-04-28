import 'dart:io';
import 'package:coachyp/features/posts/data/model/post_model.dart';

abstract class PostRemoteDataSource {
  Future<void> createPost(PostModel post);
  Future<List<PostModel>> fetchPosts();
  Future<List<PostModel>> fetchPostsByType(String type); // 🆕 Added
  Future<void> likePost(String postId, String userId);
  Future<String> uploadImage(File image);
  Future<void> unlikePost(String postId, String userId);


}
