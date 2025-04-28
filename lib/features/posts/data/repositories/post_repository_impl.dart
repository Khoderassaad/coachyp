import 'package:coachyp/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:coachyp/features/posts/domain/entities/post.dart';
import 'package:coachyp/features/posts/domain/repositories/post_repository.dart';
import 'package:coachyp/features/posts/data/model/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remote;

  PostRepositoryImpl(this.remote);

  @override
  Future<void> createPost(Post post) async {
    try {
      final model = PostModel(
        id: post.id,
        coachId: post.coachId,
        description: post.description,
        imageUrl: post.imageUrl,
        timestamp: post.timestamp,
        likes: post.likes,
        username: post.username,
        type: post.type,
        profileImgUrl: post.profileImgUrl,
        availableDates: post.availableDates,
        isActive : post.isActive,
      );
      await remote.createPost(model);
    } catch (e) {
      print('Error in createPost: $e');
      rethrow;
    }
  }

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      final models = await remote.fetchPosts();
      return models.map(_mapModelToEntity).toList();
    } catch (e) {
      print('Error in fetchPosts: $e');
      rethrow;
    }
  }

  @override
  Future<List<Post>> fetchPostsByType(String type) async {
    try {
      final models = await remote.fetchPostsByType(type);
      return models.map(_mapModelToEntity).toList();
    } catch (e) {
      print('Error in fetchPostsByType: $e');
      rethrow;
    }
  }

  @override
  Future<void> likePost(String postId, String userId) async {
    try {
      await remote.likePost(postId, userId);
    } catch (e) {
      print('Error in likePost: $e');
      rethrow;
    }
  }

  @override
  Future<void> unlikePost(String postId, String userId) async {
    try {
      await remote.unlikePost(postId, userId);
    } catch (e) {
      print('Error in unlikePost: $e');
      rethrow;
    }
  }

  Post _mapModelToEntity(PostModel model) {
    return Post(
      id: model.id,
      coachId: model.coachId,
      description: model.description,
      imageUrl: model.imageUrl,
      timestamp: model.timestamp,
      likes: model.likes,
      username: model.username,
      type: model.type,
      profileImgUrl: model.profileImgUrl,
      availableDates: model.availableDates,
    );
  }
}
