import 'package:soul_sphere/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getAllPosts();
  Future<List<PostEntity>> getPostsByUser(String userId);
  Future<void> createPost(PostEntity post);
}
